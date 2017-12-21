module SchedulesHelper
  def create_schedule(donor, member)
    p "create_schedule"
    Schedule.create(donor_id: donor, member_id: member)
  end

  def self.send_emails_batch
    p "self.send_emails_batch"
    schedules = Schedule.all

    schedules.each do |schedule|
      @donor = Donor.find(schedule.donor_id)
      @member = Member.find(schedule.member_id)

      UserMailer.welcome_email(@member, @donor).deliver_now

      schedule = Schedule.find(schedule.id)
      schedule.sent_status = true
      schedule.save
    end
  end

  def self.all_schedule
    p "self.all_schedule"
    p Schedule.all
  end
end
