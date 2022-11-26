class LogoutsController < ApplicationController

    def destroy
        session[:user_id]= nil
        redirect_to '/mains/show', notice: "Cerro"
    end
end
