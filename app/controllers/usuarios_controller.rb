class UsuariosController < ApplicationController
    include HTTParty
    include JSON
   
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
            redirect_to ( iniciar_sesion_url notice: "Creado CORRECTAMENTE") and return
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