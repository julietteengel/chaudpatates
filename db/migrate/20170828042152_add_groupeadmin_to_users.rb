class AddGroupeadminToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :groupe_admin, :boolean, :default => false
  end
end
