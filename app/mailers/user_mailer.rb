class UserMailer < ApplicationMailer
   default from: ENV['gmail_username']

  def welcome_email(member, donor)
    5.times{p "welcome email"}
    @member = member
    @donor = donor
    @url  = "https://snapthank.herokuapp.com/donors/#{@donor.id}?key=#{@donor.key}"
    mail(to: @member.email, subject: "#{@donor.name} just made a donation")
  end

  def thanks_email(donor, video)
    @donor = donor
    @video = video
    @url = "https://www.youtube.com/watch?v=#{video.link}"
    mail(to: @donor.email, subject: "Thanks for your donation #{@donor.name}")
    5.times{p "Send email"}
    destroy_donor(@donor)
  end
end
