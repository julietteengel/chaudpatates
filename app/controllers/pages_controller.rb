class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @cities = City.all
    # User.new.add_promocode_to_users_in_db
        User.where(promocode: :nil).each do |user|
      self.promocode = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(promocode: random_token)
      end
      user.save
      UserMailer.send_promocode(self)
    end
  end

  def show
  	render template: "pages/#{params[:page]}"
  end
end
