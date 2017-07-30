class UserMailer < ApplicationMailer
   default from: ENV['gmail_username'],
           reply_to: ENV['REPLY_TO']

  def welcome_email(member, donor)
    @member = member

    @team = "New Story Team"
    email_with_name = %("#{@team}" <#{member.email}>)

    @donor = donor
    @url  = "https://snapthank.herokuapp.com/donors/#{@donor.id}?key=#{@donor.key}"
    #mail(to: @member.email, subject: "#{@member.name}, your turn! #{@donor.first_name} just donated :)")

    mail(to: email_with_name, subject: "#{@member.name}, your turn! #{@donor.first_name} just donated :)")
  end

  def thanks_email(donor, video)
    @donor = donor
    @video = video
    @url = "https://www.youtube.com/watch?v=#{@video.link}"
    mail(to: @donor.email, subject: "Thanks for your donation #{@donor.first_name}")
    Donor.destroy_donor(donor)
  end
end
