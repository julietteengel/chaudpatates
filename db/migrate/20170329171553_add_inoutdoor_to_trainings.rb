class AddInoutdoorToTrainings < ActiveRecord::Migration[5.0]
  def change
    add_column :trainings, :inoutdoor, :text
  end
end
