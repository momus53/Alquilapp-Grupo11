class UsuariosController < ApplicationController
    include HTTParty
    include JSON

    def edit
        @usuario = Usuario.last
        render :edit
    end

    def show
        @usuario = Usuario.last
    end
    
    def new
        @usuario = Usuario.new(params[@usuario])
    end
    def create
        @usuario.save
    end
    def update
        @usuario = Usuario.last
        aux = params.require(:usuario).permit(:cvv,:num_tarj,:monto,:vto)
        vence = aux[:vto][5,2] + aux[:vto][2,2]
        res = post_api(@usuario.nombre+" "+@usuario.apellido,aux[:num_tarj].to_i,aux[:cvv].to_i ,vence,aux[:monto].to_i)
        if res.parsed_response["result"] == "payment_accepted"
            @usuario.increment!(:monto_actual , aux[:monto].to_i)
        else
            puts "ERROR:"
            puts res
        end
        redirect_to edit_usuario_url(@usuario,mensaje: res.parsed_response["result"])
    end


    def post_api(titular, num_tarj, cvv, vencimiento, monto)
        auth = {
            :username => "g11",
            :password => "apb9du"
        }

        payload = {
            "credit_card_holder_name": titular,
            "credit_card_number": num_tarj,
            "credit_card_code": cvv,
            "credit_card_expiration": vencimiento,
            "amount": monto
        }.to_json
        options = { 
            :body => payload, 
            :basic_auth => auth,
            :headers => {'Content-Type' => 'application/json'} 
        }

        results = HTTParty.post('https://alquilapp.is.k-pb.com.ar/grupo11/api/pay', options)
        return results
    end
end