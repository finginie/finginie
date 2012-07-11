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

  def fixed_deposits
    top_fds = [ FixedDepositCollection.top_five_public_banks_interest_rates.first,
                  FixedDepositCollection.top_five_private_banks_interest_rates.first ]

    highest_interest_fd = top_fds.select { |fd| fd.one_year_interest_rate == top_fds.map(&:one_year_interest_rate).max }
    (fd_amount / 2) > 5000 ?
      top_fds.map{ |fd| Hashie::Mash.new({:name => fd.name, :amount => fd_amount / 2  }) } :
        highest_interest_fd.map {|fd| Hashie::Mash.new({:name => fd.name, :amount => fd_amount }) }
  end

  def distinct_schemes(schemes, limit)
    distinct_schemes = []
    schemes.group_by(&:code).each { |code,plans| distinct_schemes << ( plans.select{ |scheme| scheme.plan_code == 2066}.first ||
                                                  plans.select{ |scheme| scheme.plan_code == 2067}.first ) }
    distinct_schemes.compact.take(limit)
  end

  def top_large_caps(limit=2)
    large_cap_schemes = ( DataProvider::Scheme.only(:code, :name, :plan_code, :minimum_investment_amount, :size, :entry_load, :exit_load, :prev3_year_comp_percent)
      .where(:bench_mark_index_name.in => ["BSE 100 Index", "S&P CNX 500 Equity Index", "NSE Index", "NSE CNX 100"])
        .where(:minimum_investment_amount.lte => 5000, :size.gte => 50 ).order_by([[:prev3_year_comp_percent, :desc]])
          .select{ |scheme| (scheme.entry_load.to_f + scheme.exit_load.to_f) <= 2 }.take(3*limit) + [ goldman_sachs_nifty_etf ] )
              .compact.sort_by(&:prev3_year_comp_percent).reverse.take(3*limit)
    distinct_schemes(large_cap_schemes, limit)
  end

  def goldman_sachs_nifty_etf
    DataProvider::Scheme.where( :security_code => "17024319.002066").first
  end

  def large_caps
    (large_cap_amount / 2) > 5000 ?
      top_large_caps.map { |scheme| Hashie::Mash.new({:name => scheme.name, :amount => large_cap_amount / 2  }) } :
        top_large_caps(1).map { |scheme| Hashie::Mash.new({:name => scheme.name, :amount => large_cap_amount}) }
  end

  def top_mid_caps(limit=2)
    mid_cap_schemes = DataProvider::Scheme.only(:code, :name, :plan_code, :minimum_investment_amount, :size, :entry_load, :exit_load, :prev3_year_comp_percent)
      .where(:bench_mark_index_name.in => ["CNX Midcap Index", "BSE Mid-Cap Index"])
        .where(:minimum_investment_amount.lte => 5000, :size.gte => 50 ).order_by([[:prev3_year_comp_percent, :desc]])
          .select{ |scheme| (scheme.entry_load.to_f + scheme.exit_load.to_f) <= 2 }.take(3 * limit)
    distinct_schemes(mid_cap_schemes, limit)
  end

  def mid_caps
    (mid_cap_amount / 2) > 5000 ?
      top_mid_caps.map { |scheme| Hashie::Mash.new({:name => scheme.name, :amount => mid_cap_amount / 2  }) } :
        top_mid_caps(1).map { |scheme| Hashie::Mash.new({:name => scheme.name, :amount => mid_cap_amount}) }
  end

private
  def gold_amount
    initial_investment * asset_allocation['Gold'] / 100
  end

  def fd_amount
    initial_investment * asset_allocation['Fixed Deposits'] / 100
  end

  def large_cap_amount
    asset_allocation['Large Cap Stocks'] * initial_investment / 100
  end

  def mid_cap_amount
    asset_allocation['Mid Cap Stocks'] * initial_investment / 100
  end

  def initial_investment
    [comprehensive_risk_profiler.initial_investment, IndianCurrency.new(30000)].max
  end

  def asset_allocation
    @asset_allocation ||= FinancialPlanner.ideal_asset_allocation(comprehensive_risk_profiler)
  end
end
