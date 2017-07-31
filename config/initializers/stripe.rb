Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
  secret_key:      ENV['STRIPE_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

# To test Stripe events:
 StripeEvent.event_retriever = lambda do |params|
    if params[:livemode]
        ::Stripe::Event.retrieve(params[:id])
    elsif Rails.env.development?
        # This will return an event as is from the request (security concern in production)
    ::Stripe::Event.construct_from(params.deep_symbolize_keys)
    else
        nil
    end
end

StripeEvent.configure do |events|

  # events.subscribe "invoice.payment_failed" do |event|
  #   stripe_customer_id = user.event.data.object.customer
  #   user = User.find_by(stripe_id: stripe_customer_id)
  #   PaymentMailer.payment_failed(user).deliver_now if user
  # end

  events.subscribe 'charge.failed' do |event|
    stripe_id = event.data.object['customer']

    subscription = ::Subscription.find_by_stripe_id(stripe_id)
    subscription.charge_failed
    customer = Stripe::Customer.retrieve(stripe_id)
    PaymentMailer.payment_failed(customer).deliver_now if customer
  end

  events.subscribe 'invoice.payment_succeeded' do |event|
    stripe_id = event.data.object['customer']
    amount = event.data.object['total'].to_f / 100.0
    subscription = ::Subscription.find_by_stripe_id(stripe_id)
    subscription.payment_succeeded(amount)
    customer = Stripe::Customer.retrieve(stripe_id)
    PaymentMailer.payment_succeded(customer).deliver_now if customer
  end

  events.subscribe 'customer.subscription.deleted' do |event|
    stripe_id = event.data.object['customer']
    subscription = ::Subscription.find_by_stripe_id(stripe_id)
    customer = Stripe::Customer.retrieve(stripe_id)
    customer.subscription.deleted
    PaymentMailer.subscription_deleted(customer).deliver_now if customer
  end

  events.subscribe 'charge.dispute.created' do |event|
    stripe_id = event.data.object['customer']
    subscription = ::Subscription.find_by_stripe_id(stripe_id)
    subscription.charge_disputed
  end

  events.subscribe 'customer.subscription.updated' do |event|
    stripe_id = event.data.object['customer']

    subscription = ::Subscription.find_by_stripe_id(stripe_id)
    subscription.charge_failed
    customer = Stripe::Customer.retrieve(stripe_id)
    PaymentMailer.payment_failed(customer).deliver_now if customer
  end

  events.subscribe 'customer.subscription.deleted' do |event|
    stripe_id = event.data.object['customer']
    subscription = ::Subscription.find_by_stripe_id(stripe_id)
    subscription.subscription_owner.try(:cancel)
  end

  events.all do |event|
    # Handle all event types - logging, etc.
  end

end
