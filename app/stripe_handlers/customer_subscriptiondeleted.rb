class CustomerSubscriptiondeleted
  def call(event)
    stripe_id = event.data.object['customer']
    subscription = ::Subscription.find_by_stripe_id(stripe_id)
    customer = Stripe::Customer.retrieve(stripe_id)
    subscription.try(:cancel)
    ::SubscriptionMailer.subscription_deleted(customer).deliver
  end
end
