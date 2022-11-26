class LogoutsController < ApplicationController

    def destroy
        session[:user_id]= nil
        redirect_to iniciar_sesion_url, notice: "Cerro"
    end
end
