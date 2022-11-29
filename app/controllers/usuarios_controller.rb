class UsuariosController < ApplicationController
    include HTTParty
    include JSON
   

    #archivo de vista en /app/views/index.html.erb
    #vista del administrador , gestion de usuarios
    def index
        if session[:user_id]!=nil
			@usuario = Usuario.all.find(session[:user_id])
            if @usuario.nivel.eql?("Administrador")
                
                @usuarios= Usuario.all #le cargo todos los usuarios
                @niv= params[:nivel]
                if @niv!=nil  #filtro por nivel requerido
                    if @niv.eql?("Usuario")
                        @usuarios=@usuarios.where(nivel: :"Usuario")
                    end
                    if @niv.eql?("Supervisor")
                        @usuarios=@usuarios.where(nivel: :"Supervisor")
                    end
                    if @niv.eql?("Administrador")
                        @usuarios=@usuarios.where(nivel: :"Administrador")
                    end
                end
                @ord= params[:ordenar] # ordenar por
                if @ord!=nil
                    if @ord.eql?("nivel")
                        @usuarios=@usuarios.order(:nivel)
                    end
                    if @ord.eql?("nombre")
                        @usuarios=@usuarios.order(:nombre)
                    end
                    if @ord.eql?("apellido")
                        @usuarios=@usuarios.order(:apellido)
                    end
                    if @ord.eql?("email")
                        @usuarios=@usuarios.order(:email)
                    end
                    if @ord.eql?("monto")
                        @usuarios=@usuarios.order(:monto_actual)
                    end
                    if @ord.eql?("dni")
                        @usuarios=@usuarios.order(:dni)
                    end
                    if @ord.eql?("fecha_nacimiento")
                        @usuarios=@usuarios.order(:created_at) #editar y remplazar por la fecha de nacimiento
                    end
                end
            else
                redirect_to root_url and return   #si el usuario no tiene el nivel necesario lo redirijo al mapa
            end
		else
			redirect_to mains_show_url and return   #si no tiene secion iniciada redirigo a iniciar secion
		end
    end


    #se llama desde el archivo de vista en /app/views/index.html.erb
    #metodo para subir de nivel a Supervisor
    def ascender       
        if session[:user_id]!=nil#tiene que estar loggeado
            @usuario = Usuario.all.find(session[:user_id])
            if @usuario.nivel.eql?("Administrador")#tiene que ser administrador loggeado
                @usua=Usuario.find(params[:usuario_id])#busca el usuario a ascender
                @usua.nivel="Supervisor"#Asciende el usuario a Supervisor
                if @usua.save
                    redirect_to action: "index", notice: "se Ascendio correctamente a "+@usua.nombre  and return
                else
                    render :index
                end
            else
                redirect_to root_url and return   #si el usuario no tiene el nivel necesario lo redirijo al mapa
            end
		else
			redirect_to mains_show_url and return   #si no tiene secion iniciada redirigo a iniciar secion
		end
    end

    #se llama desde el archivo de vista en /app/views/index.html.erb
    #metodo para bajar a nivel a Usuario
    def descender       
        if session[:user_id]!=nil#tiene que estar loggeado
            @usuario = Usuario.all.find(session[:user_id])
            if @usuario.nivel.eql?("Administrador")#tiene que ser administrador loggeado
                @usua=Usuario.find(params[:usuario_id])#busca el usuario a ascender
                @usua.nivel="Usuario"#Asciende el usuario a Supervisor
                if @usua.save
                    redirect_to action: "index", notice: "se degrado correctamente a "+@usua.nombre  and return
                else
                    render :index
                end
            else
                redirect_to root_url and return   #si el usuario no tiene el nivel necesario lo redirijo al mapa
            end
		else
			redirect_to mains_show_url and return   #si no tiene secion iniciada redirigo a iniciar secion
		end
    end

    #se llama desde el archivo de vista en /app/views/index.html.erb
    #metodo para eliminar un Usuario o Supervisor o Administrador
    def eliminar       
        if session[:user_id]!=nil #tiene que estar loggeado
            @usuario = Usuario.all.find( session[:user_id])
            if @usuario.nivel.eql?("Administrador") #tiene que ser administrador loggeado
                if @usuario.id != params[:usuario_id]
                    @usua=Usuario.find(params[:usuario_id]).nombre
                    Usuario.find(params[:usuario_id]).destroy
                    redirect_to action: "index", notice: "se Eliminado correctamente a "+@usua  and return
                else
                    redirect_to action: "index", notice: "No se puede eliminar a si mismo"  and return
                end
            else
                redirect_to root_url and return   #si el usuario no tiene el nivel necesario lo redirijo al mapa
            end
		else
			redirect_to mains_show_url and return   #si no tiene secion iniciada redirigo a iniciar secion
		end
    end

    def edit
        @usuario = Usuario.all.find_by(id: session[:user_id])
        render :edit
    end

    def show
        @usuario = Usuario.all.find_by(id: session[:user_id])
        if @message
            alert(message)
        end
    end
    
    def new
        @usuario = Usuario.new
        @error= params[:error]
    end

    def create
        @usuario = Usuario.new(usuario_params)
        @usuario.monto_actual=0
        @usuario.nivel="Usuario"
        
        if @usuario.save
            redirect_to mains_show_path(notice: "Creado CORRECTAMENTE") and return
        else
            @notice_error = @usuario.errors.objects.first.full_message
            redirect_to action: "new", error: @notice_error and return
        end
    end

    def update
        @usuario = Usuario.all.find_by(id: session[:user_id])
        aux = params.require(:usuario).permit(:cvv,:num_tarj,:monto,:vto)
        vence = aux[:vto][5,2] + aux[:vto][2,2]
        res = post_api(@usuario.nombre+" "+@usuario.apellido,aux[:num_tarj].to_i,aux[:cvv].to_i ,vence,aux[:monto].to_i)
        if res.parsed_response["result"] == "payment_accepted"
            @usuario.increment!(:monto_actual , aux[:monto].to_i)
        else
            puts "ERROR:"
            puts res
        end
        redirect_to edit_usuario_url(@usuario,mensaje: res.parsed_response["result"])
    end


    def post_api(titular, num_tarj, cvv, vencimiento, monto)
        auth = {
            :username => "g11",
            :password => "apb9du"
        }

        payload = {
            "credit_card_holder_name": titular,
            "credit_card_number": num_tarj,
            "credit_card_code": cvv,
            "credit_card_expiration": vencimiento,
            "amount": monto
        }.to_json
        options = { 
            :body => payload, 
            :basic_auth => auth,
            :headers => {'Content-Type' => 'application/json'} 
        }

        results = HTTParty.post('https://alquilapp.is.k-pb.com.ar/grupo11/api/pay', options)
        return results
    end
    private
    def usuario_params
    	params.require(:usuario).permit(:nombre, :apellido, :email, :dni, :pwd)
    end
end