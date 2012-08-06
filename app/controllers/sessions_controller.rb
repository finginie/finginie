class SessionsController < ApplicationController
  def success
    if session[:referral_id]
      unless current_user.already_referred?
        CompletedStep.create({
          :user_id => session[:referral_id],
          :step_id => Step::REFERRAL,
          :data    => { :referred_user_id => current_user.id }
        })
      end
    end
    current_user.merge_comprehensive_risk_profiler(session[:comprehensive_risk_profiler]) && session[:comprehensive_risk_profiler] = nil if session[:comprehensive_risk_profiler]
    @redirect_uri  = session[:user_return_to] || main_app.root_path
    flash[:notice] = special_offer?(@redirect_uri) ? I18n.t('.special_offer.message') : 'Successfully signed in'
    render :layout => false
  end

private
  def special_offer?(redirect_uri)
    redirect_uri.include?("special_offer=true")
  end
end
