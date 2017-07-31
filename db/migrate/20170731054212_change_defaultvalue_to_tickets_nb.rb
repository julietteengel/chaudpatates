class ChangeDefaultvalueToTicketsNb < ActiveRecord::Migration[5.0]
  def up
 change_column :users, :tickets_nb, :integer, default: 0
end

def down
 change_column :users, :tickets_nb, :integer, default: 1
end
end
