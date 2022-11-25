class AlquilersController < ApplicationController
    include HTTParty
    include JSON


    def show
      @autos = Auto.all
      @usuario= Usuario.find(params[:usuario])
      @usuarios = Usuario.all
    end

    def index
      @autos = Auto.all
      @usuario = Usuario.last
      @viaje = Travel.create
      render
    end

    def edit
      @usuario = Usuario.last
      render :edit
    end

    def update
        @usuario = Usuario.last
       ## aux = params.require(:usuario).permit(:monto)
       ## @usuario.increment!(:monto_actual , -aux[:monto].to_i)
    end

    def extender
      @usuario = Usuario.last
      aux = params.permit(:rango)
      puts aux[:rango]
    end



    def check_auto
      aux = params.permit(:patente)
      res = post_api_auto(aux[:patente])

      if res.parsed_response.key?("result") and res.parsed_response["result"] == "err_timeout"
        puts("TIMEOUT")
      else
        if res.parsed_response["status"]["door"] == "open" and res.parsed_response["status"]["engine"] == "on"
          puts("PUERTA ABIERTA Y MOTOR PRENDIDO")
        else
          if res.parsed_response["status"]["door"] == "open"
            puts("PUERTA ABIERTA")
          else
            if res.parsed_response["status"]["engine"] == "on"
              puts("MOTOR PRENDIDO")
            else
              puts("TODO OK")
            end
          end
        end
      end
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
