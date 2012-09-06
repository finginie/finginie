class EmailContactsController < ApplicationController
  respond_to :json

  def import_contacts
    begin
      email_contacts_decorator = EmailContactsDecorator.new(Contacts.guess!(params[:login], params[:password]))
      session[:from_email_id] = params[:login]
    rescue Contacts::AuthenticationError
      head :unauthorized and return
    rescue Contacts::TypeNotFound
      head :forbidden and return
    end

    render :json => email_contacts_decorator.data_table_response
  end

  def send_mail
    PointTracker.add_points_for(params, current_user)
    EbolaMailer.welcome_email(params[:contacts], public_financial_profile_url(current_user), session[:from_email_id]).deliver

    respond_to do |format|
      format.json  do
        render :json => { :msg => "You have invited #{params[:contacts].size} friends", :points => current_user.ebola_points }
      end
    end
  end

end
