class ChangeColumnToMembers < ActiveRecord::Migration[5.0]
  def change
    change_column :members, :city_id, :integer, :null => true
  end
end
