class IdealInvestmentPresenter

  attr_reader :ideal_investment_mix_decorator, :comprehensive_risk_profiler_decorator, :financial_planner


  delegate :valid?, :score, :private_summary, :public_summary, :public_personalize_message, :user,
           :to => :comprehensive_risk_profiler_decorator, :prefix => 'comprehensive_risk_profiler'

  delegate :investment_amount, :draw_top_elss_table, :draw_asset_chart, :draw_asset_tables, :investment_message,
           :to => :ideal_investment_mix_decorator, :prefix => 'ideal_investment'

  delegate :ideal_asset_allocation, :to => :financial_planner, :prefix => 'financial_planner'

  def initialize(user, opts={ :private => true })
    comprehensive_risk_profiler            = user.comprehensive_risk_profiler
    @financial_planner                     = FinancialPlanner.new(comprehensive_risk_profiler.score)
    amount                                 = opts[:initial_investment] || comprehensive_risk_profiler.initial_investment
    ideal_investment_mix                   = IdealInvestmentMix.new(financial_planner, amount)
    decorator_klass                        = opts[:public] ? PublicIdealInvestmentMixDecorator : IdealInvestmentMixDecorator
    @ideal_investment_mix_decorator        = decorator_klass.decorate(ideal_investment_mix)
    @comprehensive_risk_profiler_decorator = ComprehensiveRiskProfilerDecorator.decorate(comprehensive_risk_profiler)
  end
end
