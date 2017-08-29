class CreateMembersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.integer :city_id, null: false
      t.integer :user_id, null: false
      t.string :email, null: false
      t.boolean :is_a_user, :default => false
    end
  end
end
