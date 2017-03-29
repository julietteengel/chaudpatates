class ChangeDataTypeForLevel < ActiveRecord::Migration[5.0]
  def self.up
    change_table :trainings do |t|
      t.change :level, :text
    end
  end
  def self.down
    change_table :trainings do |t|
      t.change :level, :text, array: true, default: []
    end
  end
end
