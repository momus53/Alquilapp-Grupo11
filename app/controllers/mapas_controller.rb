class MapasController < ApplicationController

    def show
        @autos = Auto.all
    end

end