class CustomerSubscriptioncreated
  # pas testé - un seul mail lors de la création de souscription: invoice payments succeeded.
  def call(event)
    stripe_id = event.data.object['customer']
    subscription = ::Subscription.find_by_stripe_id(stripe_id)
    customer = Stripe::Customer.retrieve(stripe_id)
    subscription.try(:create)
    ::SubscriptionMailer.subscription_created(customer).deliver
  end
end
