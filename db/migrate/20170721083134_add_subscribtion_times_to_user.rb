class AddSubscribtionTimesToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :subscribed_at, :datetime
    add_column :users, :subscription_expires_at, :datetime
  end
end
