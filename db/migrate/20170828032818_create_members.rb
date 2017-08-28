class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members, :id => false do |t|
      t.integer :city_id, null: false
      t.integer :user_id, null: false

    end
  end
end
