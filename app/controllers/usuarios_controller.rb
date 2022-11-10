class UsuariosController < ApplicationController

    def show
        @usuario = Usuario.last
        render :show
    end

    def edit
        @usuario = Usuario.last
        render :edit
    end

    def update
        @usuario = Usuario.last
        @usuario.update(params.require(:usuario).permit(:nombre, :apellido, :monto_actual))
        redirect_to edit_usuario_url(@usuario)
    end

end