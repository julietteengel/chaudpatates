class RegistrationsController < Devise::RegistrationsController
before_filter :configure_permitted_parameters, :only => [:create]

  def new
    super
  end

  def create
    super
    # add custom create logic here
    build_resource(registration_params)
    unless resource.invite_promocode.blank?
      if User.find_by_promocode(resource.invite_promocode).present?
        user2 = User.find_by_promocode(resource.invite_promocode)
        user2.tickets_nb += 1
        user2.save
      end
    end
  end

  def update
    super
    if resource.update(users_params)
      flash[:notice] = "Votre profil a été mis à jour"
    else
      respond_to do |format|
        format.html { redirect_to(users_path) }
        format.json
      end
    end
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def users_params
    params.require(:user).permit(:photo, :email, :phone, :company, :role, :bio)
  end

  def registration_params
    params.require(:user).permit(:first_name, :last_name, :invite_promocode, :email, :password)
  end

end
