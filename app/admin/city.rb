ActiveAdmin.register City do
	menu priority: 2
	permit_params :name, :user_id, :photo, :public, :admin, :slug

  filter :name
	filter :user, label: 'COACH', collection: proc { User.is_coach }
  filter :trainings
  filter :created_at

  controller do
    def scoped_collection
      City.includes({ :trainings => :city })   # specify grandchild model with hash!
    end
  end

  form do |f|
  	f.semantic_errors *f.object.errors.keys
    inputs do
      input :name
      # input :user, label: 'Coach', collection: User.is_coach.not_linked_to_city
      # edit: now, un coach peut avoir plusieurs cities
      input :user, :label => 'Coach', :as => :select, :collection => User.all.map{|u| ["#{u.first_name} #{u.last_name}", u.id]}
      input :photo, :as => :file
      input :public, as: :boolean
      input :admin, :label => 'Admin', :as => :select, :collection => User.is_admin.map{|u| ["#{u.first_name} #{u.last_name}", u.id]}
      input :slug
    end
    actions
  end

	index do
    selectable_column
    column :id
    column :name
    column :coach
    column :admin do |m|
      unless m.admin.nil?
      usr = User.find(m.admin)
      link_to "#{usr.first_name} #{usr.last_name}", admin_user_path(m.admin)
      end
    end
    column :public, as: :boolean
    column :photo do |event|
      link_to(cl_image_tag event.photo.path, height: 50)
    end
    column :created_at
    actions
  end

end
