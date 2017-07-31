class AddSubscriptionidToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :subscription, index: true
  end
end
