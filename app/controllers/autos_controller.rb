class AutosController < ApplicationController
    

    def index
        if session[:user_id]!=nil
			@usuario = Usuario.all.find(session[:user_id])
            if @usuario.nivel.eql?("Administrador") or @usuario.nivel.eql?("Supervisor")
                @autos=Auto.all

                @filt= params[:filtro]
                if @filt!=nil  #filtro por
                    if @filt.eql?("En_Uso")
                        @autos=@autos.where(en_uso: :true)
                    end
                    if @filt.eql?("Libres")
                        @autos=@autos.where(en_uso: :false)
                    end
                end
                @ord= params[:ordenar] # ordenar por
                if @ord!=nil
                    if @ord.eql?("Nro")
                        @autos=@autos.order(:nroA)
                    end
                    if @ord.eql?("Patente")
                        @autos=@autos.order(:patente)
                    end
                    if @ord.eql?("Fecha_creado")
                        @autos=@autos.order(:created_at)
                    end
                    if @ord.eql?("Fecha_editado")
                        @autos=@autos.order(:updated_at)
                    end
                end

            else
                redirect_to root_url, notice:"no tiene el nivel suficiente para esta accion" and return   #si el usuario no tiene el nivel necesario lo redirijo al mapa
            end
		else
			redirect_to mains_show_url and return   #si no tiene secion iniciada redirigo a iniciar secion
		end
    end

    def viajes
        if session[:user_id]!=nil #tiene que estar loggeado
            @usuario = Usuario.all.find( session[:user_id])
            if @usuario.nivel.eql?("Administrador") #tiene que ser administrador loggeado
                if params[:auto_id] != nil#se necesita el id del auto
                    @viajes=Travel.all
                    @viajes=@viajes.where(auto_id: params[:auto_id])
                else
                    redirect_to action: "index", notice: "Faltan Parametros"  and return
                end
            else
                redirect_to root_url and return   #si el usuario no tiene el nivel necesario lo redirijo al mapa
            end
        else
            redirect_to mains_show_url and return   #si no tiene secion iniciada redirigo a iniciar secion
        end
    end

    #se llama desde el archivo de vista en /app/views/autos/index.html.erb
    #metodo (post) para editar un auto
    def editar
        if session[:user_id]!=nil #tiene que estar loggeado
            @usuario = Usuario.all.find( session[:user_id])
            if @usuario.nivel.eql?("Administrador") #tiene que ser administrador loggeado
                if params[:id] != nil and params[:patente]!=nil and params[:color]!=nil and params[:nroA]!=nil# necesita parametro de que auto eliminar
                    @aut=Auto.find(params[:id])
                    @aut_patente=@aut.patente
                    @aut.nroA=params[:nroA]
                    @aut.color=params[:color]
                    @aut.patente=params[:patente]
                    @aut.save
                    redirect_to action: "index", notice: "se Edito correctamente el auto "+@aut_patente  and return
                else
                    redirect_to action: "index", notice: "Faltan Parametros"  and return
                end
            else
                redirect_to root_url and return   #si el usuario no tiene el nivel necesario lo redirijo al mapa
            end
		else
			redirect_to mains_show_url and return   #si no tiene secion iniciada redirigo a iniciar secion
		end
    end

    #se llama desde el archivo de vista en /app/views/autos/index.html.erb
    #metodo para eliminar un auto
    def eliminar       
        if session[:user_id]!=nil #tiene que estar loggeado
            @usuario = Usuario.all.find( session[:user_id])
            if @usuario.nivel.eql?("Administrador") #tiene que ser administrador loggeado
                if params[:auto_id] != nil # necesita parametro de que auto eliminar
                    @aut_patente=Auto.find(params[:auto_id]).patente
                    Auto.find(params[:auto_id]).destroy
                    redirect_to action: "index", notice: "se Eliminado correctamente el auto "+@aut_patente  and return
                else
                    redirect_to action: "index", notice: "!!falta el parametro identificador del auto"  and return
                end
            else
                redirect_to root_url and return   #si el usuario no tiene el nivel necesario lo redirijo al mapa
            end
		else
			redirect_to mains_show_url and return   #si no tiene secion iniciada redirigo a iniciar secion
		end
    end

    #vista en /app/views/autos/new.html.erb
    def new
        if session[:user_id]!=nil
			@usuario = Usuario.all.find(session[:user_id])
            if @usuario.nivel.eql?("Administrador") or @usuario.nivel.eql?("Supervisor")
                @auto = Auto.new

            else
                redirect_to root_url, notice:"no tiene el nivel suficiente para esta accion" and return   #si el usuario no tiene el nivel necesario lo redirijo al mapa
            end
		else
			redirect_to mains_show_url and return   #si no tiene secion iniciada redirigo a iniciar secion
		end
    end

    #archivo de vista en /app/views/autos/new/
    #crea y guarda usuario con los parametros ingresados en la planilla
    def create
        @auto = Auto.new(auto_params)
        @auto.en_uso=false

        if @auto.save
            redirect_to action: "index", notice: "Auto Creado CORRECTAMENTE"  and return
        else
            @notice_error = @auto.errors.objects.first.full_message
            redirect_to action: "new", error: @notice_error and return
        end
    end

    private
    def auto_params
    	params.require(:auto).permit( :nroA, :color, :patente )
    end


end