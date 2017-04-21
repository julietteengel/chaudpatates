class RemoveBadgeFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :badge, :text
  end
end
