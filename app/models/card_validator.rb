class CardValidator < ApplicationRecord
    include HTTParty
    base_uri "https://alquilapp.is.k-pb.com.ar/grupo11/api/pay"

    def valid
        auth = {
            :username => "g11",
            :password => "apb9du"
        }

        payload = {
            "credit_card_holder_name":"Nombre y apellido",
            "credit_card_number": 1234567812345672,
            "credit_card_code": 223,
            "credit_card_expiration": "0226",
            "amount": 124
        }
        options = { 
            :body => payload, 
            :basic_auth => auth 
        }

        results = HTTParty.post(base_uri, options)
        puts results.code
    end

end