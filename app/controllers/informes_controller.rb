class InformesController < ApplicationController

    def index
        @informes = Informe.all
    end
    
    def new	
		@informe = Informe.new()
		#@N_auto = params[ :N_auto]
		@auto= Auto.first#find_by(nroA: params[:nroA] ) # auto asociado al informe
    end
    
    def create
		@informe = Informe.new(informe_params)	#crea el nuevo informe con los parametros permitidos 
		@informe.validado=false
		respond_to do |format|
			if @informe.save
				format.html { redirect_to root_path, notice: 'Informe Creado.' }
	#			redirect_to: informe_path
			else
				render :new
			end
		end
    end
    
    private
    def informe_params
    	params.require(:informe).permit(:titulo, :descripcion, :piezas_involucradas)
    end
     
end

