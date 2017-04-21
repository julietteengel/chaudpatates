class AddPromocodeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :promocode, :string
  end
end
