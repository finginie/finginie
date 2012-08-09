class EmailContactsController
  SUPPORTED_EMAIL_SERVERS = [:gmail, :yahoo, :hotmail]
  class UnSupportedEmailServer < Exception; end

  before_filter :validate_email_server

  def index
    # "Contacts::#{email_server.classify}"
    # Contacts::Gmail.new(login, password).contacts
    # Contacts.new(params[]).contacts
    contacts = Contacts.new(*@input).contacts
    msg = 'success'
  rescue Contacts::AuthenticationError => error_msg
    msg = error_msg
  rescue UnSupportedEmailServer => error_msg
    msg = error_msg
  ensure
    #render msg
  end

  private
  def validate_email_server
    login = params[:login]
    password = params[:password]
    email_server = (@login[/\@(.*?)\./,1]).to_sym
    raise UnSupportedEmailServer, 'this is wrong' unless SUPPORTED_EMAIL_SERVERS.include?(@email_server)
    @input = [email_server, login, password]
  end
end