class ChangeInTravels < ActiveRecord::Migration[7.0]
  def change
    change_column :travels, :contratado, :integer
    change_column :travels, :exedido, :integer
    change_column :travels, :multado, :integer
  end
end
