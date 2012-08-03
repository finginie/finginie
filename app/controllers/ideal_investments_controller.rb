class IdealInvestmentsController < InheritedResources::Base
  defaults :singleton => true, :resource_class => IdealInvestmentMix,:instance_name => 'ideal_investment_mix'
  before_filter :user_logged_in

  def resource
    @resource = super
    @resource.initial_investment = (params[:initial_investment]) if params[:initial_investment]
    starting_investment = @resource.comprehensive_risk_profiler.initial_investment
    flash[:notice] =  starting_investment > IdealInvestmentMix::MINIMUM_INVESTMENT ? t('.display_initial_investment', :amount => starting_investment) : t('.too_low_investment')
    @resource
  end

protected
  def begin_of_association_chain
    @current_user.comprehensive_risk_profiler
  end

  def user_logged_in
    unless @current_user && @current_user.comprehensive_risk_profiler.persisted?
      flash.keep(:notice)
      redirect_to edit_comprehensive_risk_profiler_path
    end
  end
end