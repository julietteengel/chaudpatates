class InvoicePaymentsucceeded
  def call(event)
    stripe_id = event.data.object['customer']
    subscription = ::Subscription.find_by_stripe_id(stripe_id)
    stripe_subscription = Stripe::Subscription.all(customer: stripe_id).first
    all_invoices = Stripe::Invoice.all(:customer => stripe_id)
    customer = Stripe::Customer.retrieve(stripe_id)
    user = User.find_by_email(customer.email)
    # puts "invoice succeded ##################"
    # paid_invoices = all_invoices.all(:paid => true)
    # if plan: 3-months and nb payments = 3 - cancel sub and send email
    # fonctionne si le client n'a souscrit qu'à un type d'abonnement depuis le début.
    # if user.subscribed? suscribed va reprendre les conditions de la ligne 12
    #   si suscribed à tel truc, user.suscribed en argument avec le plan
    #   là t's un true ou false

    # if (all_invoices.count == 3) && (stripe_subscription.plan.id == "3_months_subscription")
    #   # ci-dessous: méthode pour annuler de l'abonnement automatiquement après le 3e paiement
    #   # stripe_subscription.delete(:at_period_end => true)
    #   # user.subscribed? == false # TODO: trouver un moyen de passer en false un mois plus tard
    #   ::PaymentMailer.subscription_cancelled(subscription).deliver
    # else

      ::PaymentMailer.payment_succeeded(subscription).deliver
    # end
  end
end
