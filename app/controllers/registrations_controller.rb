class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
    # add custom create logic here
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
end
