   namespace :reminder_all_trainings do
     desc "This is to send a reminder email to all the members of a city"
     task(:reminder_email => :environment) do
      City.all.each do |c|
        @city_members = c.find_city_members
        unless @city_members.empty?
          @city_members.each do |city_member|
            c.send_reminder_all_trainings(city_member)
            end
        end
      end
    end
  end
