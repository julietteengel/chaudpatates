class InvoicePaymentsfailed
  def call(event)
    stripe_id = event.data.object['customer']
    subscription = ::Subscription.find_by_stripe_id(stripe_id)
    ::PaymentMailer.payment_failed(subscription).deliver
  end
end


# StripeEvent.configure do |events|

#   # events.subscribe "invoice.payment_failed" do |event|
#   #   stripe_customer_id = user.event.data.object.customer
#   #   user = User.find_by(stripe_id: stripe_customer_id)
#   #   PaymentMailer.payment_failed(user).deliver_now if user
#   # end
