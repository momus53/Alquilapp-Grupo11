class AlquilersController < ApplicationController
    include HTTParty
    include JSON


    def show
      @autos = Auto.all
      @usuario= Usuario.all.find_by(id: session[:user_id])
      @usuarios = Usuario.all
      if params[:auto]!=nil
          @auto=Auto.find_by(nroA: params[:auto] )
      end
    end

    def index
      auxiliar = params.permit(:auto)
      @auto = Auto.all.find_by(nroA: auxiliar[:auto])
      @usuario = Usuario.all.find_by(id: session[:user_id])
      render
    end

    def edit
      @usuario = Usuario.all.find_by(id: session[:user_id])
      render :edit
    end

    def validar #Se fija si el auto puede contratarse por el usuario
      @usuario = Usuario.all.find_by(id: session[:user_id])
      aux = params.permit(:cuartos,:nroA)
      aux2 = Auto.all.find_by(nroA: aux[:nroA])
      total= (((aux[:cuartos].to_f)/4)*1250)
      if (total<=@usuario.monto_actual)
        if (@usuario.travels.find_by(auto_id: aux2.id))
          if((@usuario.travels.where(auto_id: aux2.id).last.updated_at.advance(hours: 3)) > Time.now)
            puts 'lo uso hace poco'
            redirect_to alquiler_path(auto: aux[:nroA].to_s, id:'show', notice: "Lo uso hace menos de 3 Horas") and return
          end 
        end
            puts 'puede alquilar'
            aux2.en_uso = true
            aux2.save
            @viajero = Travel.new
            @viajero.start=Time.now
            @viajero.contratado= aux[:cuartos].to_i
            @viajero.auto_id=aux2.id
            @viajero.usuario_id=@usuario.id
            if @viajero.save
              puts "SE GUARDO"
            else
              puts "no me guarde"
            end
            @usuario.increment!(:monto_actual , -total)
            puts @viajero.start
            puts @viajero.contratado
            redirect_to action: 'index', auto: aux[:nroA].to_s, mins: ((aux[:cuartos].to_f)/4)*60 and return
      else
        puts 'No hay dinero'
        redirect_to alquiler_path(auto: aux[:nroA].to_s, id:'show', notice: "No Hay Dinero suficiente") and return
      end

    end
    def update
      puts '-----------------------------------------------------------'
        @usuario = Usuario.all.find_by(id: session[:user_id])
        aux = params.permit(:cuartos)
        total= (((aux[:cuartos].to_f)/4)*1250)
        @usuario.increment!(:monto_actual , -total)
    end

    def extender
      @usuario = Usuario.all.find_by(id: session[:user_id])
      parametros = params.permit(:rango)
      viajeActual = @usuario.travels.last
      auto = Auto.all.find_by(id: viajeActual.auto_id)

      if (((parametros[:rango].to_i)/4)*2500) < @usuario.monto_actual
        if((viajeActual.contratado + parametros[:rango].to_i) >= 96) 
          puts "LA EXTENSION EXEDE LAS 24HS"
          tiempo = ((viajeActual.contratado.to_f/4)*60*60 - (Time.now - viajeActual.created_at)) 
          tiempo = (tiempo/60).round(2)
          redirect_to alquilers_path(auto: auto.nroA.to_s,mins: tiempo, notice: "LA EXTENSION EXEDE LAS 24HS") and return
        else
          puts "PUEDE EXTENDER"
          viajeActual.contratado = viajeActual.contratado + parametros[:rango].to_i #ACTUALIZAR viajeActual.contratado
          viajeActual.save
          tiempo_extendido = ((parametros[:rango].to_i)/4)*60*60
          tiempo = ((viajeActual.contratado.to_f/4)*60*60 - (Time.now - viajeActual.created_at) + tiempo_extendido)
          tiempo = (tiempo/60).round(2)
          total = ((parametros[:rango].to_f/4)*2500)
         
          @usuario.increment!(:monto_actual , -total) #resto la plata
          redirect_to alquilers_path(auto: auto.nroA.to_s,mins: tiempo, notice: "EXTENDIDO") and return
        end
      else
        puts "NO HAY SUFICIENTE DINERO PARA EL TIEMPO ELEGIDO"
        tiempo = ((viajeActual.contratado.to_f/4)*60*60 - (Time.now - viajeActual.created_at)) 
        tiempo = (tiempo/60).round(2)
        redirect_to alquilers_path(auto: auto.nroA.to_s,mins: tiempo, notice: "NO HAY SUFICIENTE DINERO PARA EL TIEMPO ELEGIDO") and return
      end
    end



    def check_auto #checkea si se puede cerrar el alquiler(DEVOLVER)
      @usuario = Usuario.all.find_by(id: session[:user_id])
      aux = params.permit(:patente,:auto,:tex)
      res = post_api_auto(aux[:patente])
      auto = aux[:patente]
      viajeActual = @usuario.travels.last

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
      tiempo = ((viajeActual.contratado.to_f/4)*60*60 - (Time.now - viajeActual.created_at))
      tiempo = (tiempo/60).round(2)
      redirect_to alquilers_path(auto: auto,mins: tiempo, notice: salida,tex: aux[:tex]) and return
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
