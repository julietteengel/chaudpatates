class RemovePrivateDescriptionFromTraining < ActiveRecord::Migration[5.0]
  def change
    remove_column :trainings, :private_description, :text
  end
end
