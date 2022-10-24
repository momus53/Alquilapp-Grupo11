class GenerarTablaDeAutos < ActiveRecord::Migration[7.0]
  def change

    create_table :autos do |t|
      t.integer :nroA
      t.string :color
      t.string :patente
      t.boolean :en_uso

      t.timestamps
    end
  
  end
end
