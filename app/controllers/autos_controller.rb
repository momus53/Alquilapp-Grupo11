class AutosController < ApplicationController
    
    def index
        @autos = Auto.all
    end
end