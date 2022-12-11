class AutosController < ApplicationController
    

    def index
        if session[:user_id]!=nil
			@usuario = Usuario.all.find(session[:user_id])
            if @usuario.nivel.eql?("Administrador") or @usuario.nivel.eql?("Supervisor")
                @autos=Auto.all

                @filt= params[:filtro]
                if @filt!=nil  #filtro por
                    if @filt.eql?("En_Uso")
                        @autos=@autos.where(en_uso: :true)
                    end
                    if @filt.eql?("Libres")
                        @autos=@autos.where(en_uso: :false)
                    end
                end
                @ord= params[:ordenar] # ordenar por
                if @ord!=nil
                    if @ord.eql?("Nro")
                        @autos=@autos.order(:nroA)
                    end
                    if @ord.eql?("Patente")
                        @autos=@autos.order(:patente)
                    end
                    if @ord.eql?("Fecha_creado")
                        @autos=@autos.order(:created_at)
                    end
                    if @ord.eql?("Fecha_editado")
                        @autos=@autos.order(:updated_at)
                    end
                end

            else
                redirect_to root_url, notice:"no tiene el nivel suficiente para esta accion" and return   #si el usuario no tiene el nivel necesario lo redirijo al mapa
            end
		else
			redirect_to mains_show_url and return   #si no tiene secion iniciada redirigo a iniciar secion
		end
    end


    #accion tipo POST ; le descuenta x monto a un usuario; envia un main informativo;
    #llamado desde /app/views/autos/viajes.html.erb
    def multar
        if session[:user_id]!=nil #tiene que estar loggeado
            @usuario = Usuario.all.find( session[:user_id])
            if @usuario.nivel.eql?("Administrador") or @usuario.nivel.eql?("Supervisor") #tiene que ser administrador o supervisor loggeado
                if params[:travel_id] != nil and params[:usuario_id] != nil and params[:auto_id] != nil and params[:costo_multa] != nil and params[:descripcion] != nil #se necesita el id del auto
                    @us=Usuario.find(params[:usuario_id])
                    @us.monto_actual += -params[:costo_multa].to_f
                    @us.save
require 'uri'
require 'net/http'
require 'openssl'

url = URI("https://stoplight.io/mocks/railsware/mailtrap-api-docs/93404133/api/send")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(url)
request["Content-Type"] = 'application/json'
request["Api-Token"] = 'ea870da59feea208fb32d928518aa4ac'
request.body = "{\n  \"to\": [\n    {\n      \"email\": \"nicopacheco1997@gmail.com\",\n      \"name\": \"Nicolas\"\n    }\n  ],\n  \"cc\": [\n    {\n      \"email\": \"jane_doe@example.com\",\n      \"name\": \"Jane Doe\"\n    }\n  ],\n  \"bcc\": [\n    {\n      \"email\": \"james_doe@example.com\",\n      \"name\": \"Jim Doe\"\n    }\n  ],\n  \"from\": {\n    \"email\": \"sales@example.com\",\n    \"name\": \"Example Sales Team\"\n  },\n  \"attachments\": [\n    {\n      \"content\": \"PCFET0NUWVBFIGh0bWw+CjxodG1sIGxhbmc9ImVuIj4KCiAgICA8aGVhZD4KICAgICAgICA8bWV0YSBjaGFyc2V0PSJVVEYtOCI+CiAgICAgICAgPG1ldGEgaHR0cC1lcXVpdj0iWC1VQS1Db21wYXRpYmxlIiBjb250ZW50PSJJRT1lZGdlIj4KICAgICAgICA8bWV0YSBuYW1lPSJ2aWV3cG9ydCIgY29udGVudD0id2lkdGg9ZGV2aWNlLXdpZHRoLCBpbml0aWFsLXNjYWxlPTEuMCI+CiAgICAgICAgPHRpdGxlPkRvY3VtZW50PC90aXRsZT4KICAgIDwvaGVhZD4KCiAgICA8Ym9keT4KCiAgICA8L2JvZHk+Cgo8L2h0bWw+Cg==\",\n      \"filename\": \"index.html\",\n      \"type\": \"text/html\",\n      \"disposition\": \"attachment\"\n    }\n  ],\n  \"custom_variables\": {\n    \"user_id\": \"45982\",\n    \"batch_id\": \"PSJ-12\"\n  },\n  \"headers\": {\n    \"X-Message-Source\": \"dev.mydomain.com\"\n  },\n  \"subject\": \"Your Example Order Confirmation\",\n  \"text\": \"Congratulations on your order no. 1234\",\n  \"category\": \"API Test\"\n}"

response = http.request(request)
puts response.read_body

if response.read_body["success"]
    puts "--------------------------"
    puts "--------------------------"
    puts "--------------------------"
    puts "--------------------------"
    puts "--------------------------"
    puts "--------------------------"
    puts "--------------------------"
    puts "--------------------------"
    puts "--------------------------"
    puts "--------------------------"
end
#mail = Mailtrap::Sending::Mail.new(
#  from: { email: 'AlquilApp@official.com', name: 'Mailtrap Test' },
#  to: [
#    { email: 'testUsuer@email.com' }
#  ],
#  subject: 'You are awesome!',
#  text: "Congrats for sending test email with Mailtrap!",
#  category: "Integration Test"
#)
#client = Mailtrap::Sending::Client.new(api_key: 'ea870da59feea208fb32d928518aa4ac' )
#client.send(mail)

                    redirect_to action: "index", notice: "Se Multo Exitosamente a "+@us.nombre.to_s+", y se le notifico con un mail"  and return
                else
                    redirect_to action: "index", notice: "Faltan Parametros"  and return
                end
            else
                redirect_to root_url and return   #si el usuario no tiene el nivel necesario lo redirijo al mapa
            end
        else
            redirect_to mains_show_url and return   #si no tiene secion iniciada redirigo a iniciar secion
        end
    end


    #vista de la lista de viajes asociados a un auto espesifico
    #implementado en /app/views/autos/viajes.html.erb
    def viajes
        if session[:user_id]!=nil #tiene que estar loggeado
            @usuario = Usuario.all.find( session[:user_id])
            if @usuario.nivel.eql?("Administrador") or @usuario.nivel.eql?("Supervisor") #tiene que ser administrador o supervisor loggeado
                if params[:auto_id] != nil#se necesita el id del auto
                    @viajes=Travel.all
                    @viajes=@viajes.where(auto_id: params[:auto_id])
                else
                    redirect_to action: "index", notice: "Faltan Parametros"  and return
                end
            else
                redirect_to root_url and return   #si el usuario no tiene el nivel necesario lo redirijo al mapa
            end
        else
            redirect_to mains_show_url and return   #si no tiene secion iniciada redirigo a iniciar secion
        end
    end

    #se llama desde el archivo de vista en /app/views/autos/index.html.erb
    #metodo (post) para editar un auto
    def editar
        if session[:user_id]!=nil #tiene que estar loggeado
            @usuario = Usuario.all.find( session[:user_id])
            if @usuario.nivel.eql?("Administrador") #tiene que ser administrador loggeado
                if params[:id] != nil and params[:patente]!=nil and params[:color]!=nil and params[:nroA]!=nil# necesita parametro de que auto eliminar
                    @aut=Auto.find(params[:id])
                    @aut_patente=@aut.patente
                    @aut.nroA=params[:nroA]
                    @aut.color=params[:color]
                    @aut.patente=params[:patente]
                    if @aut.save
                        if Auto.where(nroA: @aut.nroA).count == 1
                        redirect_to action: "index", notice: "se Edito correctamente el auto "+@aut_patente  and return
                        else
                            redirect_to action: "index",notice: "se Edito correctamente el auto "+@aut_patente,alert: "Hay "+Auto.where(nroA: @aut.nroA).count.to_s+" Autos con el mismo numero: "+@aut.nroA.to_s+".Esto puede generar problemas en el sistema." and return
                        end
                    else
                        @notice_error = @aut.errors.objects.first.full_message
                        redirect_to action: "index",alert: "No Se Ha Podido Editar el Auto:"+@aut_patente+", Porque:"+@notice_error and return
                    end
                else
                    redirect_to action: "index", notice: "Faltan Parametros"  and return
                end
            else
                redirect_to root_url and return   #si el usuario no tiene el nivel necesario lo redirijo al mapa
            end
		else
			redirect_to mains_show_url and return   #si no tiene secion iniciada redirigo a iniciar secion
		end
    end

    #se llama desde el archivo de vista en /app/views/autos/index.html.erb
    #metodo para eliminar un auto
    def eliminar       
        if session[:user_id]!=nil #tiene que estar loggeado
            @usuario = Usuario.all.find( session[:user_id])
            if @usuario.nivel.eql?("Administrador") #tiene que ser administrador loggeado
                if params[:auto_id] != nil # necesita parametro de que auto eliminar
                    @aut_patente=Auto.find(params[:auto_id]).patente
                    Auto.find(params[:auto_id]).destroy
                    redirect_to action: "index", notice: "se Eliminado correctamente el auto "+@aut_patente  and return
                else
                    redirect_to action: "index", notice: "!!falta el parametro identificador del auto"  and return
                end
            else
                redirect_to root_url and return   #si el usuario no tiene el nivel necesario lo redirijo al mapa
            end
		else
			redirect_to mains_show_url and return   #si no tiene secion iniciada redirigo a iniciar secion
		end
    end

    #vista en /app/views/autos/new.html.erb
    def new
        if session[:user_id]!=nil
			@usuario = Usuario.all.find(session[:user_id])
            if @usuario.nivel.eql?("Administrador") or @usuario.nivel.eql?("Supervisor")
                @auto = Auto.new

            else
                redirect_to root_url, notice:"no tiene el nivel suficiente para esta accion" and return   #si el usuario no tiene el nivel necesario lo redirijo al mapa
            end
		else
			redirect_to mains_show_url and return   #si no tiene secion iniciada redirigo a iniciar secion
		end
    end

    #archivo de vista en /app/views/autos/new/
    #crea y guarda usuario con los parametros ingresados en la planilla
    def create
        @auto = Auto.new(auto_params)
        @auto.en_uso=false

        if @auto.save
            if Auto.where(nroA: @auto.nroA).count == 1
                redirect_to action: "index", notice: "Auto Creado CORRECTAMENTE"  and return
            else
                redirect_to action: "index", notice: "Auto Creado CORRECTAMENTE",alert: "Hay "+Auto.where(nroA: @auto.nroA).count.to_s+" Autos con el mismo numero: "+@auto.nroA.to_s+".Esto puede generar problemas en el sistema." and return
            end
        else
            @notice_error = @auto.errors.objects.first.full_message
            redirect_to action: "index",alert: "No Se Ha Podido Cargar el Auto:"+@notice_error and return
        end
    end

    private
    def auto_params
    	params.require(:auto).permit( :nroA, :color, :patente )
    end


end