class MapasController < ApplicationController

    def show
        @autos = Auto.all
        @usuario = Usuario.last
    end

end