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
    params[:contacts].each do |email|
      meta_data = { :invited_user_mail => email }
      share_financial_profile_mail_step = PointTracker::ShareFinancialProfileViaMailStep.new(current_user)
      share_financial_profile_mail_step.save(meta_data)
    end
    EbolaMailer.welcome_email.deliver(params[:contacts], current_user_public_financial_profile_full_path)
  end

  private
  def data_table_converted_contacts(contacts)
    data_table_converted_contacts = contacts.map do |contact|
      ["<input type='checkbox' class='invite' name='contacts[]' value='#{contact.last}' />"] + contact
    end

    { :aaData => data_table_converted_contacts }.to_json
  end
end