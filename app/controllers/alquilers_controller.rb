class AlquilersController < ApplicationController
    def show
    end

    def index
      @autos = Auto.all
    end
  end