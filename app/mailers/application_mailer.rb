class ApplicationMailer < ActionMailer::Base
  default from: "notification@teamup.com"
  layout 'mailer'
end
