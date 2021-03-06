desc "This task create new trainings every week"
task :create_weekly_trainings => :environment do
	if Time.now.monday?
	  puts "Creating trainings..."
	  CreateWeeklyTrainingsJob.perform_now
	  puts "Trainings created"
	end
end

task :reminder_email => :environment do
  if Time.current.friday? # previous answer: Date.today.wday == 5
    puts "Sending emails..."
    Rake::Task['reminder_all_trainings:reminder_email'].invoke
    puts "Emails sent"
  end
end
