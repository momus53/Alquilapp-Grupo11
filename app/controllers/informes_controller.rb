class InformesController < ApplicationController
    def index
        @informes = Informe.all
    end
    def new
        @informe = Informe.new
    end
    
end
