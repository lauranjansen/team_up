class LoginMailer < ApplicationMailer
    default from: 'notification@teamup.com'

  def welcome_mail(user)
    @user = user
    @url = "localhost:3000/" + "projects"
    mail(to: @user.email, subject: "Welcome to TeamUp!")
  end
end
