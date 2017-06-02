class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user  # Instance variable => available in view

    mail(to: @user.email, subject: 'Bienvenue sur Chaud Patate')
    # This will render a view in `app/views/user_mailer`!
  end

  def send_promocode(user)
    @user = user
    mail(to: @user.email, subject: 'Gagnez une séance gratuite !')
  end

end
