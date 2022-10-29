class GenerarTablaDeUsuarios < ActiveRecord::Migration[7.0]
  def change

    create_table :usuarios do |t|
      t.string :nombre
      t.string :apellido
      t.string :nivel
      t.float :monto_actual

      t.timestamps
    end

  end
end
