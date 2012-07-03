class SessionsController < ApplicationController
  def create
    session[:user_id] = User.find_or_create_by_omniauth request.env["omniauth.auth"]
    current_user.merge_comprehensive_risk_profiler(session[:comprehensive_risk_profiler]) && session[:comprehensive_risk_profiler] = nil if session[:comprehensive_risk_profiler]
    redirect_to success_path(:redirect_uri => session[:user_return_to] || root_path), :notice => "Successfully signed in", :only_path => true
  end

  def success
    flash[:notice] = 'Successfully signed in'
    render :layout => false
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => "Successfully signed out"
  end
end
