class CreateInformes < ActiveRecord::Migration[7.0]
  def change
    create_table :informes do |t|
    	t.belongs_to :auto , foreign_key: true
		t.belongs_to :usuario , foreign_key: true
      t.string :titulo
      t.text :descripcion
      t.integer :parte_involucrada
      t.boolean :validado  , :default => false
      t.datetime :fecha_validado

      t.timestamps
    end
  end
end
