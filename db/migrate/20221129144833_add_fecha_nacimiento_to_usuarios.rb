class AddFechaNacimientoToUsuarios < ActiveRecord::Migration[7.0]
  def change
    add_column :usuarios, :fecha_nacimiento, :datetime
  end
end
