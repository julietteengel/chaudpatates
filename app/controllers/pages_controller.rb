class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

def home
    @cities = City.all
    # User.new.add_promocode_to_users_in_db
    @user = User.where(promocode: nil)
      @user.each do |u|
      self.promocode = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(promocode: random_token)
      end
      u.save
      UserMailer.send_promocode(u)
    end
  end

  def show
  	render template: "pages/#{params[:page]}"
  end
end
