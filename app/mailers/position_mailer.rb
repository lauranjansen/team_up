class PositionMailer < ApplicationMailer
  default from: 'notification@teamup.com'

  def position_request_mail(user)
    @user = user
    mail(to: @user.email, subject: "'You've received a postion request!")
  end

end
