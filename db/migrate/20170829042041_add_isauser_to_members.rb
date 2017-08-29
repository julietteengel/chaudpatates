class AddIsauserToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :is_a_user, :boolean, :default => false
  end
end
