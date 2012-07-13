class IdealInvestmentsController < InheritedResources::Base
  defaults :singleton => true, :resource_class => IdealInvestmentMix,:instance_name => 'ideal_investment_mix'

  def resource
    @resource = super
    @resource.initial_investment=(params[:initial_investment].to_f) if params[:initial_investment]
    starting_investment = @resource.comprehensive_risk_profiler.initial_investment
    flash[:notice] =  starting_investment > IdealInvestmentMix::MINIMUM_INVESTMENT ? t('.display_initial_investment', :amount => starting_investment) : t('.too_low_investment')
    @resource
  end

protected
  def begin_of_association_chain
    @current_user.comprehensive_risk_profiler
  end
end
