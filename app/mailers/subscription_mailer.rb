class SubscriptionMailer < ApplicationMailer

  def subscription_deleted(user)
    @user = User.find_by_email(user.email)
    mail(:to => user.email, subject: 'Demande de résiliation enregistrée')
  end

  def subscription_created(user)
    @user = User.find_by_email(user.email)
    @subscription = ::Subscription.find_by_stripe_id(user.id)
    @plan = @subscription.plan
    @date = Time.current + 1.month
    mail(:to => user.email, subject: 'Votre abonnement Chaudpatate')
  end

  def source_created(user)
    @user = User.find_by_email(user.email)
    mail(:to => user.email, subject: 'Informations bancaires mises à jour')
  end

end
