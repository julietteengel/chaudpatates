Koudoku::SubscriptionsController.class_eval do
  skip_after_action :verify_policy_scoped, :only => :index, , raise: false

    def index

      # don't bother showing the index if they've already got a subscription.
      if current_owner and current_owner.subscription.present?
        redirect_to koudoku.edit_owner_subscription_path(current_owner, current_owner.subscription)
      end

      # Don't prep a subscription unless a user is authenticated.
      unless no_owner?
        # we should also set the owner of the subscription here.
        @subscription = ::Subscription.new({Koudoku.owner_id_sym => @owner.id})
        @subscription.subscription_owner = @owner
      end

      render layout: 'landing_page' # THIS IS CUSTOM
    end

end
