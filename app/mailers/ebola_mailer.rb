class EbolaMailer < ActionMailer::Base
  include Resque::Mailer

  default from: "'Finginie' <register@finginie.com>"

  def welcome_email(invited_users, share_url, from_email_id)
    @share_url  = share_url
    mail(:to => invited_users, :subject => "#{from_email_id} wants you to try Finginie")
  end
end
