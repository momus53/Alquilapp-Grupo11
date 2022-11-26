class AddEmailToUsuarios < ActiveRecord::Migration[7.0]
  def change
    add_column :usuarios, :email, :string
  end
end
