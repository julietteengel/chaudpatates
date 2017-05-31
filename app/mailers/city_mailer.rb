class CityMailer < ApplicationMailer

def reminder_all_trainings(city)
    @city = city
    @city_members = @city.find_city_members
    unless @city_members.empty?
      @city_members.each do |city_member|
        send_reminder_all_trainings(city_member)
      end
    end
end

private

def send_reminder_all_trainings(member)
    @member = member
    # date = @training.date.strftime('%A %d %Y')
    mail(to: member.email, subject: 'Les entraînements de la semaine dans votre ville!')
end

  # def send_reminder_if_not_registered(user)
  #   @user = user
  #   mail(to: @user.email, subject: 'Un entrainement a lieu aujourd\'hui dans votre ville!')
  # end

end

