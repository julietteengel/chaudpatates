class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  skip_after_action :verify_authorized, only: [:show]

  def show
    # Display the public profile of a specific user
    @user = User.find(params[:id])
    @past_events_attended = past_events_attendee(@user)
  end

private

  def past_events_attendee(user)
    @user.bookings.past
  end
end
