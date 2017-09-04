class AddIsamemberToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_a_member, :boolean, :default => false
  end
end
