class MembersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  skip_after_action :verify_authorized, only: [:show, :create]
  # before_action :set_user, only: [:update]

  def new
    @member = Member.new
    authorize @member
  end

  def create
    city = City.find_by_admin(current_user.id)
    params[:participants_addresses] = params[:participants_addresses].split(/\s|,/) if params[:participants_addresses].present?
    params[:participants_addresses].each do |email|
        @member = Member.new
        @member.email = email
        @member.user = current_user
        @member.city = city
        @member.save
        flash[:notice] = "Les membres ont bien été enregistrés"
        if User.find_by_email(email).nil? == false # déjà user
          @user = User.find_by_email(email)
          @user.is_a_member = true
          @member.is_a_user = true
          @member.save
          @user.save
          MemberMailer.user_new_member(@member).deliver
       else # user n'existe pas - envoyer mail à member et lui proposer de s'inscrire
          # envoyer un autre mail
          MemberMailer.non_user_new_member(@member).deliver
        end
      end
    redirect_to(root_path)
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
