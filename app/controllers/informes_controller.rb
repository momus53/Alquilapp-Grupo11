class InformesController < ApplicationController
	
    def index
    	if params[:nroA] != nil	#si esta definido el auto
    		puts "------------- hay auto seleccionado  --------"
    		puts "------" + params[:nroA]
    		puts "------"
    		@auto = Auto.find_by(nroA: params[:nroA]) #busca por nroA de auto
    		if @auto!= nil	#si existe ese auto
    			puts @auto.to_json
    			@informes=Informe.where(auto_id: @auto.id) # busca los informes
    			puts "------------- el auto existe  --------"
    		else
    			puts "------------- el auto NO existe  --------"
    			@informes= nil	# no hay informes para ese auto
    		end
		else
			puts "------------- No se selecciono Auto	  --------"
			@informes = Informe.all	# se muestran todos los informes
      end
      
    end
    
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

		#@informe.auto=$auto
		#@informe.usuario=$usuario
		puts "------------- se creo el informe  --------"
		respond_to do |format|
			if @informe.save
				#redirect_to root_url (:auto , :usuario , notice: "Informe Creado correctamente.") 
				#redirect_to alquilers_url
					puts " ---------- y se guardo ---------"
			else
					puts " ---------- y NO se guardo ---------"
					puts @informe.to_json
					puts "--------- "
				render :new #recargar la pagina de nuevo denuevo
			end
		end
    end
    
    private
    def informe_params
    	params.require(:informe).permit( :titulo, :descripcion, :parte_involucrada, auto: :id , usuario: :id )
    end
     
end

