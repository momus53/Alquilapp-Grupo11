class AlquilersController < ApplicationController
    def show
      @autos = Auto.all
      @usuario= Usuario.find(params[:usuario])
      @usuarios = Usuario.all
    end

    def index
      @autos = Auto.all
    end
  end
