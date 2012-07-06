class IdealInvestmentsController < InheritedResources::Base
  defaults :singleton => true, :resource_class => IdealInvestmentMix,:instance_name => 'ideal_investment_mix'
protected
  def begin_of_association_chain
    @current_user.comprehensive_risk_profiler
  end
end
