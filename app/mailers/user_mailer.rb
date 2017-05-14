class UserMailer < ApplicationMailer
   default from: 'renancontactme@gmail.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/members/'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
