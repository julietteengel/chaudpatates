class AddPublicToCities < ActiveRecord::Migration[5.0]
  def change
    add_column :cities, :public, :boolean, :default => false
  end
end
