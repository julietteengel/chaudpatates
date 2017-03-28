class AddLevelToTraining < ActiveRecord::Migration[5.0]
  def change
    add_column :trainings, :level, :text, array: true, default: []
  end
end
