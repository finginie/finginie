class EbolaMailer < ActionMailer::Base
  include Resque::Mailer

  default from: "contact2vamsi@gmail.com"

  def welcome_email(invited_users, share_url)
    @url  = "http://example.com/login"
    # invited_users = invited_users.recipients.join("; ")
    mail(:to => invited_users, :subject => "Welcome to My Awesome Site")
  end
end
