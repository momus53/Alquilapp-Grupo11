class AddDniToUsuarios < ActiveRecord::Migration[7.0]
  def change
    add_column :usuarios, :dni, :integer
  end
end
