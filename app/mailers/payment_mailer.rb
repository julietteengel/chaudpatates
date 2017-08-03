class PaymentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def payment_succeeded(subscription)
    @plan = subscription.plan
    @user = subscription.user
    @date = Time.current + 1.month
    mail(:to => subscription.user.email, :subject => "Paiment reçu pour votre abonnement Chaudpatate")
  end

  def payment_failed(user)
    @user = user
    mail(to: @user.email, subject: 'Payment failed')
  end

  def subscription_cancelled(subscription)
    @plan = subscription.plan
    @user = subscription.user
    @date = Time.current + 1.month
    mail(:to => subscription.user.email, :subject => "Votre abonnement mensuel prend fin dans un mois")
  end

end
