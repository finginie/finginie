class IdealInvestmentPresenter

  attr_reader :ideal_investment_mix_decorator, :comprehensive_risk_profiler_decorator

  %w(valid? score private_summary public_summary alert_message user).each do |method|
    delegate method, :to => :comprehensive_risk_profiler_decorator, :prefix => 'comprehensive_risk_profiler'
  end

  %w(investment_amount draw_top_elss_table draw_asset_chart draw_asset_tables alert_message).each do |method|
    delegate method, :to => :ideal_investment_mix_decorator, :prefix => 'ideal_investment'
  end

  def initialize(ideal_investment_mix, comprehensive_risk_profiler)
    @ideal_investment_mix_decorator        = IdealInvestmentMixDecorator.decorate(ideal_investment_mix)
    @comprehensive_risk_profiler_decorator = ComprehensiveRiskProfilerDecorator.decorate(comprehensive_risk_profiler)
  end
end
