class AddBadgesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :badges, :text, array: true, default: []
  end
end
