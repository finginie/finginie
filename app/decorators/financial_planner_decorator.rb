class FinancialPlannerDecorator < ApplicationDecorator
  decorates :financial_planner
  include Draper::LazyHelpers

  def risk_profilers
    model.risk_profilers.map { |rp| RiskProfilerDecorator.decorate(rp) }
  end
end
