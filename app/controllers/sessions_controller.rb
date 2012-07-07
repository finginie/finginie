class SessionsController < ApplicationController
  def success
    current_user.merge_comprehensive_risk_profiler(session[:comprehensive_risk_profiler]) && session[:comprehensive_risk_profiler] = nil if session[:comprehensive_risk_profiler]
    @redirect_uri  = session[:user_return_to] || main_app.root_path
    flash[:notice] = 'Successfully signed in'
    render :layout => false
  end
end
