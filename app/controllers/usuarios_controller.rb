class UsuariosController < ApplicationController

    def show
        @usuario = Usuario.last
    end

end