class EmailContact
  SUPPORTED_EMAIL_SERVERS = [:gmail, :yahoo, :hotmail]
  class UnSupportedEmailServer < Exception; end

  attr_reader :email, :password

  def initialize(params)
    @email        = params[:login]
    @password     = params[:password]
  end

  def friends # its wrapping contacts with checkbox info
    input = [mail_server, email, password]
    Contacts.new(*input).contacts if valid_mail_server!
  end

  private
  def valid_mail_server!
    raise UnSupportedEmailServer, 'Email Server type is not supported' unless SUPPORTED_EMAIL_SERVERS.include?(mail_server)
    return true
  end

  def mail_server
    (email[/\@(.*?)\./,1]).to_sym if email.present?
  end
end