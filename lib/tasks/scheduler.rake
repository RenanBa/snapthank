desc "This task is called by the Heroku scheduler add-on"
task :send_emails => :environment do
  SchedulesHelper::send_emails_batch
end

task :all_schedule => :environment do
  SchedulesHelper::all_schedule
end
