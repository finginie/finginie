class IdealInvestmentPresenter

  attr_reader :ideal_investment_mix_decorator, :comprehensive_risk_profiler_decorator, :financial_planner

  %w(valid? score private_summary public_summary public_personalize_message user).each do |method|
    delegate method, :to => :comprehensive_risk_profiler_decorator, :prefix => 'comprehensive_risk_profiler'
  end

  %w(investment_amount draw_top_elss_table draw_asset_chart draw_asset_tables investment_message).each do |method|
    delegate method, :to => :ideal_investment_mix_decorator, :prefix => 'ideal_investment'
  end

  delegate :ideal_asset_allocation, :to => :financial_planner, :prefix => 'financial_planner'

  def initialize(user, opts={ :private => true })
    comprehensive_risk_profiler = user.comprehensive_risk_profiler
    @financial_planner           = FinancialPlanner.new(comprehensive_risk_profiler.score)
    amount                      = opts[:initial_investment] || comprehensive_risk_profiler.initial_investment
    ideal_investment_mix        = IdealInvestmentMix.new(financial_planner, amount)

    if opts[:public]
      @ideal_investment_mix_decorator        = PublicIdealInvestmentMixDecorator.decorate(ideal_investment_mix)
    else
      @ideal_investment_mix_decorator        = IdealInvestmentMixDecorator.decorate(ideal_investment_mix)
    end
    @comprehensive_risk_profiler_decorator = ComprehensiveRiskProfilerDecorator.decorate(comprehensive_risk_profiler)
  end
end
