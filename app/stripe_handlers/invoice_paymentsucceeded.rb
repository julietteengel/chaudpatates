class InvoicePaymentsucceeded
  def call(event)
    stripe_id = event.data.object['customer']
    subscription = ::Subscription.find_by_stripe_id(stripe_id)
    ::PaymentMailer.payment_succeeded(subscription).deliver
  end
end
