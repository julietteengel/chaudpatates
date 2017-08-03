Rails.configuration.stripe = {
  publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
  secret_key:      ENV['STRIPE_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
StripeEvent.authentication_secret = ENV['STRIPE_WEBHOOK_SECRET']

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
  events.subscribe 'invoice.payment_succeeded', InvoicePaymentsucceeded.new
  events.subscribe "invoice.payment_failed", InvoicePaymentsfailed.new
  # events.subscribe "customer.subscription_created", CustomerSubscriptioncreated.new
  events.subscribe "customer.subscription.deleted", CustomerSubscriptiondeleted.new
  events.subscribe "customer.subscription.created", CustomerSubscriptioncreated.new
  events.subscribe "customer.source.created", CustomerSourcecreated.new
end


# # pas testé
#   events.subscribe 'charge.failed' do |event|
#     stripe_id = event.data.object['customer']

#     subscription = ::Subscription.find_by_stripe_id(stripe_id)
#     subscription.charge_failed
#     customer = Stripe::Customer.retrieve(stripe_id)
#     PaymentMailer.payment_failed(customer).deliver_now if customer
#   end




# # pas testé
#   events.subscribe 'customer.subscription.deleted' do |event|
#     stripe_id = event.data.object['customer']
#     subscription = ::Subscription.find_by_stripe_id(stripe_id)
#     customer = Stripe::Customer.retrieve(stripe_id)
#     customer.subscription.deleted
#     PaymentMailer.subscription_deleted(customer).deliver_now if customer
#   end

# # pas testé
#   events.subscribe 'charge.dispute.created' do |event|
#     stripe_id = event.data.object['customer']
#     subscription = ::Subscription.find_by_stripe_id(stripe_id)
#     subscription.charge_disputed
#   end

# # pas testé
#   events.subscribe 'customer.subscription.updated' do |event|
#     stripe_id = event.data.object['customer']

#     subscription = ::Subscription.find_by_stripe_id(stripe_id)
#     subscription.charge_failed
#     customer = Stripe::Customer.retrieve(stripe_id)
#     PaymentMailer.payment_failed(customer).deliver_now if customer
#   end

#   events.subscribe 'customer.subscription.deleted' do |event|
#     stripe_id = event.data.object['customer']
#     subscription = ::Subscription.find_by_stripe_id(stripe_id)
#     subscription.subscription_owner.try(:cancel)
#   end

#   events.all do |event|
#     # Handle all event types - logging, etc.
#   end

# end
