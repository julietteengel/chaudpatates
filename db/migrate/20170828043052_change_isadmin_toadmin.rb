class ChangeIsadminToadmin < ActiveRecord::Migration[5.0]
  def change
    rename_column :cities, :is_admin, :admin
  end
end
