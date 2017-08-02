class Cancel3monthsubscription
  def call(event)
    stripe_id = event.data.object['customer']
    subscription = ::Subscription.find_by_stripe_id(stripe_id)
    customer = Stripe::Customer.retrieve(stripe_id)
    ::SubscriptionMailer.source_created(customer).deliver
  end
end
