class CreateTravels < ActiveRecord::Migration[7.0]
  def change
    create_table :travels do |t|
      t.time :start
      t.time :ends
      t.time :exedido
      t.time :contratado
      t.time :multado

      t.timestamps
    end
  end
end
