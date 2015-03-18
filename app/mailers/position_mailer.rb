class PositionMailer < ApplicationMailer
  default from: 'notification@teamup.com'

  def position_request_mail(user, project)
    @project = project
    @user = user
    @url = "www.teamup.com" + "#{project_path(@project)}"
    mail(to: @user.email, subject: "'You've received a postion request!")
  end

end
