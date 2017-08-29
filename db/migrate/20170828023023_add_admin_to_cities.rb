class AddAdminToCities < ActiveRecord::Migration[5.0]
  def change
    add_column :cities, :is_admin, :integer, :default => nil
  end
end
