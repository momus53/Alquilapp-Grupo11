class AlquilersController < ApplicationController
    include HTTParty
    include JSON
    helper_method :check_auto


    def show
      @autos = Auto.all
      @usuarios = Usuario.all
    end

    def index
      @autos = Auto.all
      @usuario = Usuario.last
      render
    end

    def edit
      @usuario = Usuario.last
      render :edit
    end

    def update
        @usuario = Usuario.last
        puts "HOLAAAAAAA"
       ## aux = params.require(:usuario).permit(:monto)
       ## @usuario.increment!(:monto_actual , -aux[:monto].to_i)
    end

    def check_auto
      puts "AAASDKOASKOAOOOOEKEOKEO"
      res = post_api_auto("ASD 555")
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