class EbolaMailer < ActionMailer::Base
  include Resque::Mailer

  default from: 'register@finginie.com'

  def welcome_email(invited_users, share_url, from_email_id)
    @url  = share_url
    @fom_email = from_email_id
    invited_users = invited_users.join("; ")
    mail(:to => invited_users, :subject => "Welcome to My Awesome Site")
  end
end
