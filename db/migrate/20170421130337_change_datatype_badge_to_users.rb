class ChangeDatatypeBadgeToUsers < ActiveRecord::Migration[5.0]
  def self.up
    change_table :users do |t|
      t.change :badge, :text
    end
  end
  def self.down
    change_table :users do |t|
      t.change :badge, :text, array: true, :default => []
    end
  end
end
