ActiveAdmin.register Training do
	menu priority: 5
	permit_params :public_description, :private_description, :city_id, :location_id, :date, :level

  filter :city
  filter :location
  filter :public_description
  filter :private_description
  filter :date
  # filter :level, label: 'LEVEL', collection: Training::LEVELS
  filter :level, label: 'LEVEL', collection: proc { Training::LEVELS }
  filter :created_at

  controller do
    def scoped_collection
      Training.includes(:location)  # specify grandchild model with hash!
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    inputs do
      input :city
      input :location
      input :public_description
      input :private_description
      input :level, label: 'LEVEL', collection: Training::LEVELS
      input :date, :minute_step => 5
    end
    actions
  end

	index do
    selectable_column
    column :id
    column :date
    column :location
    column :level
    column :public_description
    column :private_description
    column :created_at
    actions
  end

end
