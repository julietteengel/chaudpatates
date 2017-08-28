class MembersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  skip_after_action :verify_authorized, only: [:show]
  # before_action :set_user, only: [:update]

  def new
    @member = Member.new
    authorize @member
  end

  def create
    @member = Member.new(member_params)
    @member.city = current_user.city
    @member.user = current_user
    authorize @training
    if @training.save
      flash[:notice] = "Ce nouvel entrainement a bien été créé"
      redirect_to(trainings_path)
    else
      flash[:alert] = "L'entraînement n'a pas pu être rajouté, merci de vérifier les erreurs ci-dessous"
      render :new
    end
  end



  # def edit
  #   @user = User.find(params[:id])
  # end

  # def update
  #   if @user.update(users_params)
  #     flash[:notice] = "Votre profil a été mis à jour"
  #   else
  #     respond_to do |format|
  #       format.html { redirect_to(users_path) }
  #       format.json
  #     end
  #   end
  # end

private


  def past_events_attendee(user)
    @user.bookings.past
  end

  def member_params
    params.require(:member).permit(:email)
  end

  # def set_user
  #   @user = User.find(params[:id])
  #   authorize @user
  # end

end
