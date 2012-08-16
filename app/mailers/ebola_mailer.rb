class EbolaMailer < ActionMailer::Base
  default from: "contact2vamsi@gmail.com"

  def welcome_email
    @url  = "http://example.com/login"
    test_users = ['vamsi@finginie.com', 'vamsi.skrishna@gmail.com']
    mail(:to => 'vamsi.skrishna@gmail.com', :subject => "Welcome to My Awesome Site")
  end
end
