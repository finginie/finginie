class EbolaMailer < PostageApp::Mailer
  include Resque::Mailer

  default from: "'Finginie' <register@finginie.com>"

  def welcome_email(invited_users, share_url, from_email_id)
    @share_url  = share_url
    @from_user = from_email_id.split("@")[0]

    headers['Reply-To'] = "'Finginie' <register@finginie.com>"

    mail(
      :from => from_email_id,
      :subject => "#{from_email_id} wants you to try Finginie",
      :to => invited_users
      )
  end
end
