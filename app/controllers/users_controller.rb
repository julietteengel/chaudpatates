class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :edit, :update]
  skip_after_action :verify_authorized, only: [:show, :edit, :update]
  before_action :set_user, only: [:update]

  def show
    # Display the public profile of a specific user
    @user = User.find(params[:id])
    @past_events_attended = past_events_attendee(@user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(users_params)
      flash[:notice] = "Votre profil a été mis à jour"
    else
      respond_to do |format|
        format.html { redirect_to(users_path) }
        format.json
      end
    end
  end

private

  def past_events_attendee(user)
    @user.bookings.past
  end

  def users_params
    params.require(:user).permit(:photo, :email, :phone, :company, :role, :bio)
  end

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

end
