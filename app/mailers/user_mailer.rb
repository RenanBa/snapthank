require 'mail'
class UserMailer < ApplicationMailer
  address = Mail::Address.new ENV['gmail_username']
  address.display_name = "New Story Team"

  default from: address.format
          #ENV['gmail_username'],
          #reply_to: ENV['REPLY_TO']

  def welcome_email(member, donor)
    @member = member
    @donor = donor
    @url  = "https://snapthank.herokuapp.com/donors/#{@donor.id}?key=#{@donor.key}"
    mail(to: @member.email, subject: "#{@member.name}, your turn! #{@donor.first_name} just donated :)")
  end

  def thanks_email(donor, video)
    @donor = donor
    @video = video
    @url = "https://www.youtube.com/watch?v=#{@video.link}"
    mail(to: @donor.email, subject: "Thanks for your donation #{@donor.first_name}")
    Donor.destroy_donor(donor)
  end
end
