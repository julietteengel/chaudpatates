   namespace :reminder_all_trainings do
     desc "This is to send a reminder email to all the members of a city"
     task(:reminder_email => :environment) do
     CityMailer.reminder_all_trainings(self).deliver_now
     end
     end
