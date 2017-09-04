class SubscribersController < ApplicationController
  before_filter :authenticate_user!
  skip_after_action :verify_policy_scoped
  skip_after_action :verify_authorized

  def index
  end


  def plans
    @stripe_list = Stripe::Plan.all
    @plans = @stripe_list[:data]
  end

  def new
    @stripe_list = Stripe::Plan.all
    @plans = @stripe_list[:data]
  end

  def create
    # @stripe_list = Stripe::Plan.all
    # @plans = @stripe_list[:data]
    @plan_id = params[:plan_id]
    @stripe_list = Stripe::Plan.all
    @plans = @stripe_list[:data]
    @plan = Stripe::Plan.retrieve(@plan_id)
    stripe_token = params[:stripeToken]
    if current_user.save_and_make_payment(@plan, stripe_token)
      current_user.suscribed = true
      flash[:notice] = "Successfully created a charge"
      redirect_to subscribers_path
    else
      render :new
    end

  end


end
