# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Auto.destroy_all

# Start IDs sequence at 1 for both monsters and tweets tables
#ActiveRecord::Base.connection.execute("ALTER SEQUENCE autos_id_seq RESTART WITH 1")

auto1 = Auto.create(nroA: 1, color: "Rojo", patente: "666 NNN" , en_uso: true)
auto2 = Auto.create(nroA: 3, color: "Verde", patente: "544 ALO" , en_uso: true)
auto3 = Auto.create(nroA: 4, color: "Rojo", patente: "112 ADW" , en_uso: false)
auto4 = Auto.create(nroA: 2, color: "Azul", patente: "487 LOQ" , en_uso: false)
auto5 = Auto.create(nroA: 5, color: "Blanco", patente: "065 QWE" , en_uso: true)
