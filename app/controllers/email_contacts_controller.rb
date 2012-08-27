class EmailContactsController < ApplicationController
  respond_to :json

  def index
    begin
      email_contacts_decorator = EmailContactsDecorator.new(Contacts.guess!(params[:login], params[:password]))
      session[:from_email_id] = params[:login]
    rescue Contacts::AuthenticationError => error_msg
      render :status => 401, :json => error_msg.message and return
    rescue Contacts::TypeNotFound => error_msg
      render :status => 403, :json => error_msg.message and return
    end

    respond_to do |format|
      format.json do
        render :json => email_contacts_decorator.data_table_response
      end
    end
  end

  def send_mail
    params[:contacts].each do |email|
      meta_data = { :invited_user_mail => email }
      share_financial_profile_mail_step = PointTracker::ShareFinancialProfileViaMailStep.new(current_user)
      share_financial_profile_mail_step.save(meta_data)
    end
    EbolaMailer.welcome_email(params[:contacts], current_user_public_financial_profile_full_path, session[:from_email_id]).deliver

    respond_to do |format|
      format.json do
        render :json => { :msg => "You have invited #{params[:contacts].size} friends", :points => current_user.ebola_points }
      end
    end
  end

end
