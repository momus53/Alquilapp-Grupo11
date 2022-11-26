class MapasController < ApplicationController

    def show
        @autos = Auto.all
        @usuario = Usuario.all.find_by(id: session[:user_id])
    end

end