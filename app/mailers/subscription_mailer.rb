class SubscriptionMailer < ApplicationMailer

  def subscription_deleted(user)
    mail(:to => user.email, subject: 'Subscription Deleted')
  end

  def subscription_created(user)
    mail(:to => user.email, subject: 'Subscription Created')
  end

  def source_created(user)
    mail(:to => user.email, subject: 'Informations bancaires mises à jour')
  end

end
