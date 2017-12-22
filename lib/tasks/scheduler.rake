desc "This task is called by the Heroku scheduler add-on"
task :send_emails => :environment do
  SchedulesHelper::send_emails_batch
end

task :all_schedule => :environment do
  SchedulesHelper::all_schedule
end

task :add_all_schedule => :environment do
  SchedulesHelper::add_all_schedule
end

task :add_to_schedule => :environment do
  SchedulesHelper::add_to_schedule
end

task :destroy_schedule => :environment do
  SchedulesHelper::destroy_schedule
end
