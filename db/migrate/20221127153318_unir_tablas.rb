class UnirTablas < ActiveRecord::Migration[7.0]
  def change
    change_table :travels do |t|
    t.belongs_to :auto , foreign_key: true
    t.belongs_to :usuario , foreign_key: true
    end
  end
end
