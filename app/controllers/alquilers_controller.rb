class AlquilersController < ApplicationController
    def show
      @autos = Auto.all
      @usuarios = Usuario.all
    end
  end