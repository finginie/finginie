class EmailContactsController < ApplicationController
  respond_to :json

  def import
    result = data_table_converted_contacts(EmailContact.new(params).friends)

    respond_to do |format|
      format.json do
        render :json => result
      end
    end

  rescue Contacts::AuthenticationError => error_msg
    render :status => 401, :json => error_msg.message
  rescue EmailContact::UnSupportedEmailServer => error_msg
    render :status => 403, :json => error_msg.message
  end

  def send_mail
    EbolaMailer.welcome_email.deliver
  end

  private
  def data_table_converted_contacts(contacts)
    data_table_converted_contacts = contacts.map do |contact|
      ["<input type='checkbox' class='a' name='vehicle' value='#{contact.last}' />"] + contact
    end

    { :aaData => data_table_converted_contacts }.to_json
  end
end