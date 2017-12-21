desc "This task is called by the Heroku scheduler add-on"
task :send_emails => :environment do
  puts "Updating feed..."
  # NewsFeed.update
  SchedulesHelper::send_emails_batch
  puts "done."
end

task :all_schedule => :environment do
  SchedulesHelper::all_schedule
end
