module SchedulesHelper
  def create_schedule(donor, member)
    p "create_schedule"
    Schedule.create(donor_id: donor, member_id: member)
  end

  def self.send_emails_batch
    p "self.send_emails_batch"

    today = Time.now
    today = today - 8*60*60 # Add 8 hours to the UTC to match PST
    if (today.tuesday? || today.thursday?)
      puts "Sending scheduled emails"
      schedules = Schedule.all

      schedules.each do |schedule|
        @donor = Donor.find(schedule.donor_id)
        @member = Member.find(schedule.member_id)
        schedule.destroy
        UserMailer.welcome_email(@member, @donor).deliver_now
      end
    else
      puts "Today isn't the emails delivery day"
    end
  end

  def self.add_to_schedule(donor, member)
    p "self.add_to_schedule"
    Schedule.create(donor_id: donor, member_id: member)
  end

  def self.add_all_schedule
    p "self.add_all_schedule"
    donors = Donor.all
    donors.each do |donor|
      member = select_member(donor)
      Schedule.create(donor_id: donor, member_id: member)
    end

  end

  def self.all_schedule
    p "self.all_schedule"
    p Schedule.all
  end
end
