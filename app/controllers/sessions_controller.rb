class SessionsController < ApplicationController
  def success
    sessions_handler = SessionsHandler.new(current_user)
    sessions_handler.success_callback(session)
    clear_session!(:comprehensive_risk_profiler, :referrer_id)
    @redirect_uri  = session[:user_return_to] || main_app.root_path
    flash[:notice] = special_offer?(@redirect_uri) ? I18n.t('.special_offer.message') : 'Successfully signed in'
    render :layout => false
  end

private
  def special_offer?(redirect_uri)
    redirect_uri.include?("special_offer=true")
  end

  def clear_session!(*args)
    session[args] = nil
  end
end
