# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_11_10_040144) do
  create_table "autos", force: :cascade do |t|
    t.integer "nroA"
    t.string "color"
    t.string "patente"
    t.boolean "en_uso"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "informes", force: :cascade do |t|
    t.string "titulo"
    t.string "descripcion"
    t.string "piezas_involucradas"
    t.boolean "validado"
    t.datetime "fecha_validado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "travels", force: :cascade do |t|
    t.time "start"
    t.time "ends"
    t.time "exedido"
    t.time "contratado"
    t.time "multado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "nombre"
    t.string "apellido"
    t.string "nivel"
    t.float "monto_actual"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
