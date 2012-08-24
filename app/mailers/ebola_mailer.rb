class EbolaMailer < ActionMailer::Base
  include Resque::Mailer

  default from: "contact2vamsi@gmail.com"

  def welcome_email(invited_users, share_url)
    @share_url  = share_url
    mail(:to => invited_users, :subject => "Welcome to My Awesome Site")
  end
end
