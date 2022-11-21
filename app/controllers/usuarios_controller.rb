class UsuariosController < ApplicationController
    def show
        @usuario = Usuario.last
    end
    
    def new
        @usuario = Usuario.new(params[@usuario])
    end
    def create
        @usuario.save
    end
end