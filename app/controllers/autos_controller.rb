class AutosController < ApplicationController
    
    def index
        @autos = Auto.all
    end

    def show
        if params[:auto]!=nil
            @auto=Auto.find_by(nroA: params[:auto] )
        end
    end
end