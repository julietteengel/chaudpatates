class PaymentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def subscription_deleted(user)
    mail(:to => subscription.user.email, subject: 'Subscription Deleted')
  end

  def payment_succeeded(subscription)
    # @subscription = subscription
    # mail(to: @user.email, subject: 'Payment succeeded')
    mail(:to => subscription.user.email, :subject => "My Subscription Invoice")
  end

  def payment_failed(user)
    @user = user
    mail(to: @user.email, subject: 'Payment failed')
  end


end
