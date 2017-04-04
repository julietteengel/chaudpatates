ActiveAdmin.register Training do
  permit_params :city_id, :location_id, :date, :level, :inoutdoor
	menu priority: 5
  filter :city
  filter :location
  # filter :public_description
  # filter :private_description
  filter :date
  filter :level, label: 'LEVEL', collection: Training::LEVELS
  filter :inoutdoor, label: 'Indoor/Outdoor', collection: Training::INOUTDOORS
  filter :created_at

  controller do
    def scoped_collection
      Training.includes(:location)  # specify grandchild model with hash!
    end
    def destroy
      Training.find(params[:id]).members.each do |member|
      member.tickets_nb += 1
      member.save
      end
      Training.destroy(params[:id])
    end
  end


  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      input :city
      input :location
      # input :public_description
      # input :private_description
      input :level, as: :select, collection: Training::LEVELS
      input :inoutdoor, as: :select, collection: Training::INOUTDOORS
      input :date, :minute_step => 5
    end
    f.actions
  end

	index do
    selectable_column
    column :id
    column :date
    column :location
    column :level
    column :inoutdoor
    # column :level do
    #   select :level, collection: Training::LEVELS
    # end
    # column :public_description
    # column :private_description
    column :created_at
    actions
  end

end
