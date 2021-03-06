class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :store_current_location, unless: :devise_controller?
  before_filter :set_tickets_package_for_order
  before_filter :set_current_user

  include Pundit

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

def set_current_user
  Booking.current_user = current_user
end

def after_sign_in_path_for(resource)
    if resource.admin == true
      admin_root_path
    else
      user_path(resource)
    end
end

  private

  def set_tickets_package_for_order
    @tickets_package = TicketsPackage.first
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :photo, :invite_promocode, :is_a_member])
    # devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :photo])
  end

  def store_current_location
    store_location_for(:user, request.url)
  end

  def user_not_authorized
    flash[:alert] = "Vous n'êtes pas autorisé à effectuer cette action."
    redirect_to(request.referrer || root_path)
  end


  # def set_current_user
  #   User.current_user = current_user
  # end


  # def set_admin_timezone
  #   Time.zone = 'Paris'
  # end
end
