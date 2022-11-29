class MapasController < ApplicationController
    include HTTParty
    include JSON


    def show
        if session[:user_id]!=nil
			@usuario = Usuario.all.find_by(id: session[:user_id])
		else
			@usuario = nil
		end
        @autos = Auto.all
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