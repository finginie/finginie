class IdealInvestmentsController < InheritedResources::Base
  defaults :singleton => true, :resource_class => IdealInvestmentMix, :instance_name => 'ideal_investment_mix'
  before_filter :user_logged_in, :only => [:show]

  def public
    user = User.find(params[:id])
    session[:referrer_id] ||= user.id
  end

  def resource
    @ideal_investment ||= begin
      current_user.ideal_investment_presenter(params[:initial_investment])
    end
  end

  protected
  def user_logged_in
    unless current_user && current_user.comprehensive_risk_profiler.persisted?
      flash.keep(:notice)
      redirect_to edit_comprehensive_risk_profiler_path
    end
  end
end