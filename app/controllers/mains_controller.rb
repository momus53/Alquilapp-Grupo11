class MainsController < ApplicationController
    def show
    end
    def validar
        campos= params.permit(:email,:pwd)
        @usuario= Usuario.all.find_by(email: campos[:email])
        if (@usuario and @usuario.pwd == campos[:pwd])
            session[:user_id]=@usuario.id
            puts session
        else
            puts 'Usuario o contraseña incorrecta'
        end



        puts '---------------------------------------------Hololo-------------------------------------------------------------'
    end


end
