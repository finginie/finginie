class IdealInvestmentsController < InheritedResources::Base
  defaults :singleton => true, :resource_class => IdealInvestmentMix, :instance_name => 'ideal_investment_mix'
  load_and_authorize_resource :user, :parent => false
  before_filter :user_taken_quiz?, :only => [:show]

  def resource
    @ideal_investment ||= current_user.ideal_investment(:initial_investment => params[:initial_investment])
  end

  protected
  def user_taken_quiz?
    unless current_user.has_comprehensive_risk_profiler?
      flash.keep(:notice)
      redirect_to edit_comprehensive_risk_profiler_path
    end
  end
end