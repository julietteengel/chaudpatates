class AddInvitePromocodeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :invite_promocode, :string
  end
end
