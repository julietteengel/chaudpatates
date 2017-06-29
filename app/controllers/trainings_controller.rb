class TrainingsController < ApplicationController
  require 'active_support/all'
	before_action :set_training, only: [:update, :destroy, :send_order_email]
	skip_after_action :verify_policy_scoped, :only => :index

	def index
		if current_user.is_coach
      if current_user.city
			@trainings = current_user.city.trainings.upcoming_plus_30min.order(:date).includes(:location)
		  end
    else
			@trainings = Training.all
		end
	end

  def new
    @training = Training.new
    authorize @training
  end

  def create
    @training = Training.new(training_params)
    @training.city = current_user.city
    authorize @training
    if @training.save
      flash[:notice] = "Ce nouvel entrainement a bien été créé"
      redirect_to(trainings_path)
    else
      flash[:alert] = "L'entraînement n'a pas pu être rajouté, merci de vérifier les erreurs ci-dessous"
      render :new
    end
  end

  def update
    if @training.update(training_params)
      flash[:notice] = "Cet entraînement a été mis à jour"
    else
      respond_to do |format|
        format.html { redirect_to(trainings_path) }
        format.js
      end
    end
  end

	def destroy
  @training.members.each do |member|
      member.tickets_nb += 1
      member.save
  end
    if @training.destroy
      flash[:notice] = "Cet entrainement a bien été annulé"
    else
    	flash[:alert] = "Des utilisateurs se sont déjà inscrits à cet entrainement, vous ne pouvez plus l'annuler"
    end
    redirect_to(trainings_path)
	end

  def send_order_email

  end

	private

  def training_params
    params.require(:training).permit(:date, :location_id, :level, :inoutdoor)
  end

  def set_training
    @training = Training.find(params[:id])
    authorize @training
  end

end
