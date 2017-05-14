class UserMailer < ApplicationMailer
   default from: 'renancontactme@gmail.com'

  def welcome_email(member)
    @member = member
    @url  = 'http://localhost:3000/members/'
    mail(to: @member.email, subject: 'Welcome to My Awesome Site')
  end
end
