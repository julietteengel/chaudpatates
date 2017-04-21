class AddBadgeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :badge, :text
  end
end
