class MapasController < ApplicationController
    include HTTParty
    include JSON


    def show
        @autos = Auto.all
        if session[:user_id] != nil
			@usuario = Usuario.all.find_by(id: session[:user_id])
            aux = params.permit(:notice,:tex)
            if(aux[:notice] == "viaje_terminado")
                cerrar_viaje(aux[:tex])
                @ultimo_viaje = @usuario.travels.last
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
        auto = viaje.auto
        auto.en_uso = false
        auto.save
        viaje.ends = Time.now
        viaje.exedido = tex
        cobro = tex.to_f/60/60/4*5000
        @usuario.increment!(:monto_actual , -cobro)
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