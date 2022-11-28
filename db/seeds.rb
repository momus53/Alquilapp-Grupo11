# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first) in
Auto.destroy_all
Usuario.destroy_all
Informe.destroy_all
# Start IDs sequence at 1 for both monsters and tweets tables

#ActiveRecord::Base.connection.execute("ALTER SEQUENCE autos_id_seq RESTART with 1")
#ActiveRecord::Base.connection.execute("ALTER SEQUENCE usuarios_id_seq RESTART with 1")

auto1 = Auto.create(nroA: 1, color: "Rojo", patente: "NNN 666" , en_uso: true)
auto2 = Auto.create(nroA: 3, color: "Azul", patente: "ALO 544" , en_uso: false)
auto3 = Auto.create(nroA: 4, color: "Rojo", patente: "ADW 112" , en_uso: false)
auto4 = Auto.create(nroA: 2, color: "Azul", patente: "LO 487 FR" , en_uso: false)
auto5 = Auto.create(nroA: 5, color: "Blanco", patente: "AS 065 QW" , en_uso: true)
auto6 = Auto.create(nroA: 6, color: "Blanco", patente: "RTM 898 AR" , en_uso: false)

user1 = Usuario.create(nombre: "Alan", apellido: "Pichot", monto_actual: 2500, nivel: "Supervisor",dni:42312315, email: "alan@pro.com", pwd:'12345')
user2 = Usuario.create(nombre: "Sandro", apellido: "Mareco", monto_actual: 1889.0, nivel: "Usuario",dni:40312115, email: "san@dro",pwd: "12345")
user3 = Usuario.create(nombre: "Fernando", apellido: "Peralta", monto_actual: 0, nivel: "Administrador",dni:49312315, email: "frend@proCress.com")
user4 = Usuario.create(nombre: "Beth", apellido: "Harmon", monto_actual: 0, nivel: "Supervisor",dni:35312315, email: "beti@proCress.com")
user5 = Usuario.create(nombre: "Tomas", apellido: "Sosa", monto_actual: -89.9, nivel: "Usuario",dni:40853689, email: "tomiton@proCress.com")

inf1 = Informe.create(titulo: "toque en paragolpe", descripcion: "en el paragolpe trasero tiene un golpe, y le falta un pedazo de plastico", parte_involucrada: 9 , validado: false , auto: auto2 , usuario: user2)
inf2 = Informe.create(titulo: "espejito roto", descripcion: "el espejo derecho esta golpeado y trabado", parte_involucrada: 17 , validado: false , auto: auto2 , usuario: user2)
inf3 = Informe.create(titulo: "le falta 1 espejo, puerta golpeada", descripcion: "tiene un golpe del lado del conductor, le falta el espejo izquierdo, y la puerta no cierra bien", parte_involucrada: 22 , validado: true, fecha_validado: DateTime.new(2022, 11, 9, 22, 35, 0) , auto: auto1 , usuario: user1)
inf4 = Informe.create(titulo: "golpe en el vidrio frontal", descripcion: "el vidrio frontal esta astillado, tiene un golpe", parte_involucrada: 4 , validado: false , auto: auto4 , usuario: user5)


parte1 = Parte.create(id:1, nombre:"Capó")
parte2 = Parte.create(id:2, nombre:"Guardafango")
parte3 = Parte.create(id:3, nombre:"Puerta Delantera")
parte4 = Parte.create(id:4, nombre:"Parabrisas delantero")
parte5 = Parte.create(id:5, nombre:"Silla delantera")
parte6 = Parte.create(id:6, nombre:"Costado")
parte7 = Parte.create(id:7, nombre:"Stop")
parte8 = Parte.create(id:8, nombre:"Tapa baúl")
parte9 = Parte.create(id:9, nombre:"Paragolpes trasero")
parte10 = Parte.create(id:10, nombre:"Panel trasero")
parte11 = Parte.create(id:11, nombre:"Parabrisas trasero")
parte12 = Parte.create(id:12, nombre:"Capota")
parte13 = Parte.create(id:13, nombre:"Consola central")
parte14 = Parte.create(id:14, nombre:"Timón")
parte15 = Parte.create(id:15, nombre:"Tablero de instrumentos")
parte16 = Parte.create(id:16, nombre:"Espejo interior")
parte17 = Parte.create(id:17, nombre:"Espejo exterior")
parte18 = Parte.create(id:18, nombre:"Farola o unidad delantera")
parte19 = Parte.create(id:19, nombre:"Luz antiniebla")
parte20 = Parte.create(id:20, nombre:"Paragolpes delantero")
parte21 = Parte.create(id:21, nombre:"Vidrio puerta delantera")
parte22 = Parte.create(id:22, nombre:"Vidrio puerta trasera")
parte23 = Parte.create(id:23, nombre:"Puerta trasera")
parte24 = Parte.create(id:24, nombre:"Vidrio costado")
parte25 = Parte.create(id:25, nombre:"LLanta")
parte26 = Parte.create(id:26, nombre:"Estribo")
parte27 = Parte.create(id:27, nombre:"Rin")



Time.now
tra1= Travel.create(start: Time.now.advance(hours: -3), ends: Time.now, auto_id: auto6.id, usuario_id: 1)
tra2= Travel.create(start: Time.now.advance(hours: -6), ends: Time.now.advance(hours: -3), auto_id: auto3.id, usuario_id: 1)
