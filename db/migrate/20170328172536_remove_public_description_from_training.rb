class RemovePublicDescriptionFromTraining < ActiveRecord::Migration[5.0]
  def change
    remove_column :trainings, :public_description, :text
  end
end
