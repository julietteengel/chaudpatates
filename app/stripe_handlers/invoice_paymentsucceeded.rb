class InvoicePaymentsucceeded
  def call(event)
    stripe_id = event.data.object['customer']
    subscription = ::Subscription.find_by_stripe_id(stripe_id)
    # if plan: 3-months and nb payments = 3 - cancel sub and send email
    # if (Stripe::Invoice.all(:customer => stripe_id).count == 3) && (subscription.plan_id == 1)
    #   subscription.delete
    #   ::PaymentMailer.subscription_cancelled(subscription).deliver
    # else
      ::PaymentMailer.payment_succeeded(subscription).deliver
  end
end
