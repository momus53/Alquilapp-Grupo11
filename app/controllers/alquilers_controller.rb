class AlquilersController < ApplicationController
    include HTTParty
    include JSON


    def show
      @autos = Auto.all
      @usuario= Usuario.all.find_by(id: session[:user_id])
      @usuarios = Usuario.all
    end

    def index
      @autos = Auto.all
      @usuario = Usuario.all.find_by(id: session[:user_id])
      @viaje = Travel.create
      render
    end

    def edit
      @usuario = Usuario.all.find_by(id: session[:user_id])
      render :edit
    end

    def update
        @usuario = Usuario.all.find_by(id: session[:user_id])
       ## aux = params.require(:usuario).permit(:monto)
       ## @usuario.increment!(:monto_actual , -aux[:monto].to_i)
    end

    def extender
      @usuario = Usuario.all.find_by(id: session[:user_id])
      aux = params.permit(:rango)
      puts aux[:rango]
    end



    def check_auto
      aux = params.permit(:patente,:auto,:mins)
      res = post_api_auto(aux[:patente])

      if res.parsed_response.key?("result") and res.parsed_response["result"] == "err_timeout"
        puts("TIMEOUT")
        salida = "TIMEOUT"
      else
        if res.parsed_response["status"]["door"] == "open" and res.parsed_response["status"]["engine"] == "on"
          puts("PUERTA ABIERTA Y MOTOR PRENDIDO")
          salida = "PUERTA_ABIERTA_Y_MOTOR_PRENDIDO"
        else
          if res.parsed_response["status"]["door"] == "open"
            puts("PUERTA ABIERTA")
            salida = "PUERTA_ABIERTA"
          else
            if res.parsed_response["status"]["engine"] == "on"
              puts("MOTOR PRENDIDO")
              salida = "MOTOR_PRENDIDO"
            else
              puts("TODO OK")
              salida = "TODO_OK"
            end
          end
        end
      end
      redirect_to alquilers_path(auto: 4,mins: 60,msg: salida)
    end

    def post_api_auto(patente)
        auth = {
            :username => "g11",
            :password => "apb9du"
        }

        payload = {
          "vehicle_id": patente
        }.to_json

        options = { 
            :body => payload, 
            :basic_auth => auth,
            :headers => {'Content-Type' => 'application/json'} 
        }

        results = HTTParty.post('https://alquilapp.is.k-pb.com.ar/grupo11/api/vehicle-status', options)
        return results
    end
  end
