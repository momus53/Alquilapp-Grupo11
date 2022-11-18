class InformesController < ApplicationController

	$auto
	$usuario
	
    def index
        @informes = Informe.all
    end
    
    # /app/views/informes/new.html.erb 
    def new	
		$auto= Auto.find(params[:auto]) 	# traigo el auto seleccionado por parametro
		$usuario= Usuario.find(params[:usuario]) #traigo el usuario seleccionado por parametro
		@informe = Informe.new(auto: @auto ,usuario: @usuario) #creo el informe
		respond_to do |f|
			f.html { redirect_to 'Alquiler#index',notice :"informe creado correctamente" }
		end
    end
    
    def create
		@informe = Informe.new(informe_params )	#crea el nuevo informe con los parametros permitidos 
		@informe.validado=false
		@informe.auto=$auto
		@informe.usuario=$usuario
		puts "------------- se creo el informe  --------"
		respond_to do |format|
			if @informe.save
				redirect_to alquilers_url(:auto , :usuario , notice: 'Informe Creado correctamente.') 
				#redirect_to alquilers_url
					puts " ---------- y se guardo ---------"
			else
					puts " ---------- y NO se guardo ---------"
					puts @informe.to_json
					puts  $auto.to_json
					puts "--------- "
				render :new #recargar la pagina de nuevo denuevo
			end
		end
    end
    
    private
    def informe_params
    	params.require(:informe).permit(:titulo, :descripcion, :parte_involucrada, :auto , :usuario)
    end
     
end

