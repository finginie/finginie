require 'addressable/uri'
class SessionsController < ApplicationController
  def success
    sessions_handler = SessionsHandler.new(current_user)
    sessions_handler.success_callback(session)
    clear_session!(:comprehensive_risk_profiler, :referrer_id)

    query =  callback_uri.query_values
    @redirect_uri  = callback_uri.path.empty? main_app.root_path || callback_uri.path
    flash[:notice] = I18n.t(".#{query['message'] || 'signin'}.message")

    render :layout => false
  end

private
  def callback_uri
    @uri ||= Addressable::URI.parse session[:user_return_to]
  end
end
