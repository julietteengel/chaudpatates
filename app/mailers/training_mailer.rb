class TrainingMailer < ApplicationMailer
  def cancellation(training)
    @training = training
    @members  = @training.members
    @members.each do |member|
      send_cancellation_email(member)
    end
  end

  def reminder_if_registered(training)
    @training = training
    @location = @training.location
    @members  = @training.members
    @members.each do |member|
      send_reminder_if_registered(member)
    end
  end

  def reminder_if_not_registered(training)
    @training = training
    @members  = @training.members
    @user = user
    @users = User.all
    # if user is in city and is not registered to this training
    @users.each do |u|
      if @members.exclude? u && u.city == @training.city # éventuellement : rajouter, and if training is not full
        send_reminder_if_not_registered(u)
      end
    end
  end

  private

  def send_cancellation_email(member)
    @member = member
    date = @training.date.strftime('%A %d %Y')
    mail(to: member.email, subject: 'Annulation de l\'entrainement')
  end

def send_reminder_if_registered(member)
    @member = member
    mail(to: member.email, subject: 'Votre entrainement a lieu aujourd\'hui!')
  end

  def send_reminder_if_not_registered(user)
    @user = user
    mail(to: @user.email, subject: 'Un entrainement a lieu aujourd\'hui dans votre ville!')
  end

end
