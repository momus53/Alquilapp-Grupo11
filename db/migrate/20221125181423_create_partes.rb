class CreatePartes < ActiveRecord::Migration[7.0]
  def change
    create_table :partes do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
