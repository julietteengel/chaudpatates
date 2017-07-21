class StripeController < ApplicationController

  protect_from_forgery :except => :webhooks

  def webhooks
    event_json = JSON.parse(request.body.read)
    event = Stripe::Event.retrieve(event_json["id"])

    if event.type =~ /^customer.subscription/
      subscriber = User.find_by(customer_id: event.data.object.customer)
      subscriber.subscribed_at = Time.at(event.data.object.start).to_datetime
      subscriber.subscription_expires_at = Time.at(event.data.object.current_period_end).to_datetime
      subscriber.save
    end

    render nothing: true
  end

end
