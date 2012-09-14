class IdealInvestmentsController < InheritedResources::Base
  defaults :singleton => true, :resource_class => IdealInvestmentMix, :instance_name => 'ideal_investment_mix'
  before_filter :user_logged_in, :only => [:show]

  def resource
    @ideal_investment ||= begin
      IdealInvestmentPresenter.new(current_user, :initial_investment => params[:initial_investment])
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