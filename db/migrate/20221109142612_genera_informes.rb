class GeneraInformes < ActiveRecord::Migration[7.0]
  def change
      create_table :informes do |t|
      t.string :titulo
      t.string :descripcion
      t.string :piezas_involucradas
      t.boolean :validado
      t.datetime :fecha_validado
      t.timestamps
    end
  end
end
