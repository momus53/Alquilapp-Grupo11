class MapasController < ApplicationController
    include HTTParty
    include JSON


    def show
        if session[:user_id] != nil
			@usuario = Usuario.all.find_by(id: session[:user_id])
            @autos = Auto.all
            aux = params.permit(:notice,:tex)
            if(aux[:notice] == "viaje_terminado")
                @ultimo_viaje = @usuario.travels.last
                cerrar_viaje(aux[:tex])
            end
		else
			@usuario = nil
		end


       # arr = Array.new(@autos.where(en_uso: false).length * 3)

        #@autos.where(en_uso: false).each do |a|
        #    res = post_api_auto(a.nroA.to_s)
        #    id = a.nroA.to_s
        #    lat = res.parsed_response["status"]["location"]["lat"]
        #    lon = res.parsed_response["status"]["location"]["lon"]
        #    arr.push(id,lat,lon)
        #end

        #@autosLibres = arr
    end

    def cerrar_viaje(tex)
        @usuario = Usuario.all.find_by(id: session[:user_id])
        viaje = @usuario.travels.last
        viaje.ends = Time.now
        viaje.exedido = tex
        viaje.save
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