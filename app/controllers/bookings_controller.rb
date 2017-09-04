class BookingsController < ApplicationController

	before_action :set_booking, only: :destroy

	def index
		@bookings = policy_scope(Booking).includes( { training: [:location, :city] } )
		set_favorite_city
    authorize @bookings
  end

	def create
		@booking = Booking.new
		@booking.training = Training.find(params[:training])
		@booking.user = current_user
		@training = @booking.training
		authorize @booking
    # empecher de pouvoir réserver deux fois le même booking
    if current_user.bookings.include? @booking
      respond_to do |format|
        format.html {
          flash[:alert] = "Vous avez déjà booké cette séance!"
          redirect_to city_path(params[:city])
        }
        format.js
        end
    else
      # si user est membre de cette ville, pas besoin de payer TODO
      # if current_user.is_a_member && current_user.city

      # if current_user
       if current_user.subscribed? # If current_user has a plan
          @booking.notify_customer if @booking.save
           current_user.save
           respond_to do |format|
            format.html {
              flash[:notice] = "Votre réservation a bien été prise en compte !!"
              redirect_to city_path(params[:city])
              }
              format.js
          end
        elsif current_user.tickets_nb > 0 # If current_user has tickets
              @booking.notify_customer if @booking.save
              @tickets_before_booking = current_user.tickets_nb
              current_user.tickets_nb -= 1
              current_user.save
              respond_to do |format|
                format.html {
                flash[:notice] = "Votre réservation a bien été prise en compte !!"
                redirect_to city_path(params[:city])
                }
                format.js
              end
        else # user has to buy tickets or subscribed
          @tickets_before_booking = 0
                flash[:notice] = "Pour booker, achetez des tickets ou un abonnement"
                render js: "window.location.href = '#{orders_path}'"
		    end
      end
	end

	def destroy
    # If current_user has a plan
    if current_user.subscribed? && @booking.destroy
      respond_to do |format|
        format.html {
          flash[:notice] = "Votre inscription a bien été annulée"
          redirect_to(bookings_path)
        }
        format.js
      end
   #  elsif (Time.current < @booking.training.date - 1.day) && @booking.destroy
			# current_user.tickets_nb += 1
			# current_user.save
   #    respond_to do |format|
   #      format.html {
   #        flash[:notice] = "Votre inscription a bien été annulée"
   #        redirect_to(bookings_path)
   #      }
   #      format.js
   #    end
    else
      respond_to do |format|
        format.html {
          flash[:alert] = "Votre inscription à l'entrainement n'a pas été annulée"
          (render :index)
        }
        format.js
      end
    end
	end

	private

	def set_favorite_city
		@favorite_city = current_user.favorite_city
	end

  def set_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end

end
