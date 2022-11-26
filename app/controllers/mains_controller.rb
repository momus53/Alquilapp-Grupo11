class MainsController < ApplicationController
    def show
    end
    
    def validar
        campos= params.permit(:email,:pwd)
        @usuario= Usuario.all.find_by(email: campos[:email])
        if (@usuario and @usuario.pwd == campos[:pwd])
            session[:user_id]=@usuario.id
            if @usuario.nivel == "Usuario"
                redirect_to root_url
            else 
                redirect_to '/usuarios/show/edit'
            end
        else
            redirect_to ( iniciar_sesion_url notice: 'Usuario o Contraseña incorrecta')
        end
        puts '---------------------------------------------Hololo-------------------------------------------------------------'
    end


end
