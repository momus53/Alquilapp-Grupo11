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
auto6 = Auto.create(nroA: 6, color: "Blanco", patente: "RTM 8983AR" , en_uso: false)

user1 = Usuario.create(nombre: "Alan", apellido: "Pichot", monto_actual: 170.8, nivel: "Supervisor")
user2 = Usuario.create(nombre: "Sandro", apellido: "Mareco", monto_actual: 1889.0, nivel: "Usuario")
user3 = Usuario.create(nombre: "Fernando", apellido: "Peralta", monto_actual: 0, nivel: "Administrador")
user3 = Usuario.create(nombre: "Beth", apellido: "Harmon", monto_actual: 0, nivel: "Supervisor")
user5 = Usuario.create(nombre: "Tomas", apellido: "Sosa", monto_actual: -89.9, nivel: "Usuario")

inf1 = Informe.create(titulo: "toque en paragolpe", descripcion: "en el paragolpe trasero tiene un golpe, y le falta un pedazo de plastico", parte_involucrada: 9 , validado: false , auto: auto2 , usuario: user2)
inf2 = Informe.create(titulo: "espejito roto", descripcion: "el espejo derecho esta golpeado y trabado", parte_involucrada: 17 , validado: false , auto: auto2 , usuario: user2)
inf3 = Informe.create(titulo: "le falta 1 espejo, puerta golpeada", descripcion: "tiene un golpe del lado del conductor, le falta el espejo izquierdo, y la puerta no cierra bien", parte_involucrada: 22 , validado: true, fecha_validado: DateTime.new(2022, 11, 9, 22, 35, 0) , auto: auto1 , usuario: user1)
inf4 = Informe.create(titulo: "golpe en el vidrio frontal", descripcion: "el vidrio frontal esta astillado, tiene un golpe", parte_involucrada: 4 , validado: false , auto: auto4 , usuario: user5)



tra1= Travel.create()





