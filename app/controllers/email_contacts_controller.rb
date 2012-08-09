class EmailContactsController < ApplicationController
  SUPPORTED_EMAIL_SERVERS = [:gmail, :yahoo, :hotmail]
  class UnSupportedEmailServer < Exception; end

  # before_filter :validate_email_server

  respond_to :json

  def import
    validate_email_server!
    contacts = Contacts.new(*@input).contacts
    contacts.map!{ |contact| ["<input type='checkbox' class='a' name='vehicle' value='Bike' />"] + contact }
    result = {
      :aaData => contacts
    }

    respond_to do |format|
      format.json do
        render :json => result.to_json
      end
    end

  rescue Contacts::AuthenticationError => error_msg
    render :status => 401, :json => error_msg.message
  rescue UnSupportedEmailServer => error_msg
    render :status => 403, :json => error_msg.message
  end

  private
  def validate_email_server!
    email = params[:login]
    password = params[:password]
    email_server = (email[/\@(.*?)\./,1]).to_sym if email.present?
    raise UnSupportedEmailServer, 'Email type is not supported' unless SUPPORTED_EMAIL_SERVERS.include?(email_server)
    @input = [email_server, email, password]
  end
end