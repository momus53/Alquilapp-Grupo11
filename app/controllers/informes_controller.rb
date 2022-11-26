class InformesController < ApplicationController
	
    def index
		if session[:user_id]!=nil
			@usuario = Usuario.all.find_by(id: session[:user_id])
		else
			redirect_to iniciar_sesion_url and return
		end

		if params[:nroA] != nil	#si esta definido el auto
    		@auto = Auto.find_by(nroA: params[:nroA]) #busca por nroA de auto
    		if @auto!= nil	#si existe ese auto
    			@informes=Informe.where(auto_id: @auto.id) # busca los informes
				@informes=@informes.where(validado: true)	#solo deja los informes validados
				@partes=Parte.all	# le pasa el nombre de todas las piezas de los autos
    		else
    			@informes= nil	# no hay informes para ese auto
    		end
      	end

    end
	
	
	# accion lanzada desde /app/views/informes/index.html.erb 
	# formato de link tipico : http://localhost:3000/informes/validar?validar=true&auto=3&usuario_validado=1
	def validar	# valida o invalida un Informe
		if session[:user_id]!=nil
			@usuario = Usuario.all.find_by(id: session[:user_id])
		else
			redirect_to iniciar_sesion_url and return
		end

		if params[:validar]!= nil and params[:auto]!= nil and params[:informe_validado_id]!= nil
			if @usuario.nivel.eql?("Administrador") or @usuario.nivel.eql?("Supervisor") # si tiene nivel suficiente
				@informe=Informe.find(params[:informe_validado_id])
					@informe.validado=params[:validar]
					@informe.fecha_validado=Time.now;
					@informe.save
					puts "---->>>se modifico la validacion de un informe"
			end
		end
		redirect_to action: "index", nroA: params[:auto] and return
	end


    
    # /app/views/informes/new.html.erb 
    def new
		if session[:user_id]!=nil
			@usuario = Usuario.all.find_by(id: session[:user_id])
		else
			redirect_to iniciar_sesion_url and return
		end
		
		@informe= nil # establesco por defecto un informe nulo
		if params[:nroA] != nil 
			@auto= Auto.find_by(nroA: params[:nroA]) 	# traigo el auto por nroA seleccionado por parametro
			if (@auto != nil)	# si existen el auto y el usuario seleccionados
				@informe = Informe.new(auto: @auto ,usuario: @usuario) # creo el informe
			else
				@notice_error=" debe ingresar numero de auto <nroA:4>"
			end
		end
    end
    
    def create
		@informe = Informe.new(informe_params )	#crea el nuevo informe con los parametros permitidos
		@informe.validado=false

		if Usuario.find(@informe.usuario_id).nivel.eql?("Supervisor") #valida automaticamente los informes de Supervisores
			@informe.validado=true
		end

		if Usuario.find(@informe.usuario_id).nivel.eql?("Administrador") #valida automaticamente los informes de administradores
			@informe.validado=true
		end

		puts "------------- se creo el informe  --------"
		respond_to do |format|
			if @informe.save
				#redirect_to root_url (:auto , :usuario , notice: "Informe Creado correctamente.") 
				#redirect_to alquilers_url
					puts " ---------- y se guardo ---------"
					redirect_to action: "index", nroA: @informe.auto.nroA and return
	
			else
					puts " ---------- y NO se guardo ---------"
					flash[:notice] = "Lo que podia fallar, Fallo! "
					puts @informe.to_json
					puts "--------- "
				render :new #recargar la pagina de nuevo denuevo
			end
		end
    end
    
    private
    def informe_params
    	params.require(:informe).permit(  :titulo, :descripcion, :parte_involucrada, :auto_id , :usuario_id )
    	#params.require(:auto)
    	#params.require(:usuario)
    end
     
end

