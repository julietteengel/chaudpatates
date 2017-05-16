class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

def home
    @cities = City.all
    # User.new.add_promocode_to_users_in_db
    @users = User.where(promocode: nil)
      @users.each do |u|
        u.promocode = loop do
          random_token = SecureRandom.urlsafe_base64(nil, false)
          break random_token unless u.class.exists?(promocode: random_token)
        end
      u.save
      UserMailer.send_promocode(u).deliver_now
    end
  end

  def show
  	render template: "pages/#{params[:page]}"
  end
end
