class AlquilersController < ApplicationController
    def show
      @autos = Auto.all
      @usuarios = Usuario.all
    end

    def index
      @autos = Auto.all
    end
  end