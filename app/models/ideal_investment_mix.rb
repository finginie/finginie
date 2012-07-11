class IdealInvestmentMix

  attr_reader :comprehensive_risk_profiler

  def initialize(comprehensive_risk_profiler)
    @comprehensive_risk_profiler = comprehensive_risk_profiler
  end

  def top_gold_etfs
    DataProvider::Scheme.where(:name.in => ['Goldman Sachs Gold Exchange Traded Scheme-Growth',
      'SBI Gold Exchange Traded Scheme-Growth', 'Kotak Gold ETF-Growth' ])
        .order_by([[:prev3_year_comp_percent, :desc]]).limit(2)
  end

  def gold_investments
    (gold_amount / 2) > 5000 ? top_gold_etfs
      .map{ |scheme| Hashie::Mash.new({:name => scheme.name, :amount => gold_amount / 2  }) } :
        top_gold_etfs.take(1).map { |scheme| Hashie::Mash.new({:name => scheme.name, :amount => gold_amount }) }
  end

private
  def gold_amount
    initial_investment * asset_allocation['Gold'] / 100
  end

  def initial_investment
    [comprehensive_risk_profiler.initial_investment, IndianCurrency.new(30000)].max
  end

  def asset_allocation
    @asset_allocation ||= FinancialPlanner.ideal_asset_allocation(comprehensive_risk_profiler)
  end
end
