class UserMailer < ApplicationMailer
   default from: 'renancontactme@gmail.com'

  def welcome_email(member, donor)
    @member = member
    @donor = donor
    @url  = "https://snapthank.herokuapp.com/donors/#{@donor.id}"
    mail(to: @member.email, subject: "#{@donor.name} just made a donation")
  end

  def thanks_email(donor, video)
    @donor = donor
    @video = video
    @url = "https://www.youtube.com/watch?v=#{video.link}"
    mail(to: @donor.email, subject: "Thanks for your donation #{@donor.name}")
  end
end
