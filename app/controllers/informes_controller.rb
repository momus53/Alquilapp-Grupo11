class InformesController < ApplicationController
	
    def index
		if params[:usuario] != nil
			@usuario=Usuario.find(params[:usuario])
		else
			@usuario=nil
		end

		if params[:nroA] != nil	#si esta definido el auto
    		@auto = Auto.find_by(nroA: params[:nroA]) #busca por nroA de auto
    		if @auto!= nil	#si existe ese auto
    			@informes=Informe.where(auto_id: @auto.id) # busca los informes
				if @usuario.nivel.eql?("Usuario")	#si ingresa un usuario
					@informes=@informes.where(validado: true)#solo deja los informes validados
				end
				@partes=Parte.all
    		else
    			@informes= nil	# no hay informes para ese auto
    		end
		else
			puts "------------- No se selecciono Auto	  --------"
			@informes = Informe.all	# se muestran todos los informes
      	end
		
		if params[:notice] !=nil
			@notice=params[:notice]
		end
      
    end

	def validar	# valida o invalida un Informe
		if params[:validar]!= nil and  params[:usuario]!= nil and params[:auto]!= nil and params[:informe_validado_id]!= nil
			@usuario=Usuario.find(params[:usuario])
			if @usuario.nivel.eql?("Administrador") or @usuario.nivel.eql?("Supervisor") # si tiene nivel suficiente

				@informe=Informe.find(params[:informe_validado_id])
					@informe.validado=params[:validar]
					@informe.fecha_validado=Time.now;
					@informe.save

			end
		end
		redirect_to action: "index", nroA: params[:auto] , usuario: params[:usuario] and return
	end
	# formato de link tipico : http://localhost:3000/informes/validar?validar=true&usuario=1&auto=3&usuario_validado=1
    
    # /app/views/informes/new.html.erb 
    def new	
    	@informe= nil # establesco por defecto un informe nulo
    	if ( params[:nroA] != nil ) and (params[:usuario] != nil) 
    		if ( params[:usuario].to_i > 0 )	#si estan los parametros necesarios		
		 		@auto= Auto.find_by(nroA: params[:nroA]) 	# traigo el auto por nroA seleccionado por parametro
				@usuario= Usuario.find(params[:usuario]) #traigo el usuario por id seleccionado por parametro
				if (@auto != nil)	and ( @usuario != nil)	# si existen el auto y el usuario seleccionados
					@informe = Informe.new(auto: @auto ,usuario: @usuario) # creo el informe
		 		else
		 			@notice_error=" no se encontro el usuario, o auto pedido"
		 		end
		 	else
				@notice_error=" numero de usuario no puede ser negativo"
		 	end
		 	@notice_error="debe ingresar ambos parametros "
    	end	
    end
    
    def create
		@informe = Informe.new(informe_params )	#crea el nuevo informe con los parametros permitidos
		@informe.validado=false

		if Usuario.find(@informe.usuario_id).nivel.eql?("Supervisor") #valida automaticamente los informes de Supervisores
			@informe.validado=true
			@informe.fecha_validado=Time.now;
		end

		if Usuario.find(@informe.usuario_id).nivel.eql?("Administrador") #valida automaticamente los informes de administradores
			@informe.validado=true
			@informe.fecha_validado=Time.now;
		end

		puts "------------- se creo el informe  --------"
		respond_to do |format|
			if @informe.save
				#redirect_to root_url (:auto , :usuario , notice: "Informe Creado correctamente.") 
				#redirect_to alquilers_url
					puts " ---------- y se guardo ---------"
					redirect_to action: "index", nroA: @informe.auto.nroA , usuario: @informe.usuario.id, notice: "Informe Creado Correctamente" and return
	
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

