class MapasController < ApplicationController

    def show
        if session[:user_id]!=nil
			@usuario = Usuario.all.find_by(id: session[:user_id])
		else
			redirect_to iniciar_sesion_url and return
		end
        @autos = Auto.all
    end

end