ActiveAdmin.register Location do
	menu priority: 3
	permit_params :name, :address, :photo

	filter :training
  filter :name
  filter :address
  filter :created_at

  form do |f|
  	f.semantic_errors *f.object.errors.keys
    inputs do
      input :name
      input :address, placeholder: "Exemple de format : 16 Villa Gaudelet, 75011 Paris"
      input :photo, :as => :file
    end
    actions
  end

	index do
    selectable_column
    column :id
    column :name
    column :address
    column :photo do |event|
    	link_to(cl_image_tag event.photo.path, height: 50)
  	end
    column :created_at
    actions
  end

end
