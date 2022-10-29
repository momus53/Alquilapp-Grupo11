# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first) in
Auto.destroy_all
Usuario.destroy_all
# Start IDs sequence at 1 for both monsters and tweets tables

#ActiveRecord::Base.connection.execute("ALTER SEQUENCE autos_id_seq RESTART with 1")
#ActiveRecord::Base.connection.execute("ALTER SEQUENCE usuarios_id_seq RESTART with 1")

auto1 = Auto.create(nroA: 1, color: "Rojo", patente: "NNN 666" , en_uso: true)
auto2 = Auto.create(nroA: 3, color: "Verde", patente: "ALO 544" , en_uso: true)
auto3 = Auto.create(nroA: 4, color: "Rojo", patente: "ADW 112" , en_uso: false)
auto4 = Auto.create(nroA: 2, color: "Azul", patente: "LO 487 FR" , en_uso: false)
auto5 = Auto.create(nroA: 5, color: "Blanco", patente: "AS 065 QW" , en_uso: true)

user1 = Usuario.create(nombre: "Alan", apellido: "Pichot", monto_actual: 170.8, nivel: "Supervisor")
user2 = Usuario.create(nombre: "Sandro", apellido: "Mareco", monto_actual: 1889.0, nivel: "Usuario")
user3 = Usuario.create(nombre: "Fernando", apellido: "Peralta", monto_actual: 0, nivel: "Administrador")
user4 = Usuario.create(nombre: "Tomas", apellido: "Sosa", monto_actual: -89.9, nivel: "Usuario")
