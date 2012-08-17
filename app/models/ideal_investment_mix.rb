class IdealInvestmentMix

  MINIMUM_INVESTMENT = IndianCurrency.new(30000)
  MINIMUM_AMOUNT_FOR_INVESTMENT = 5000

  attr_reader :comprehensive_risk_profiler
  attr_accessor :initial_investment

  def initialize(comprehensive_risk_profiler)
    @comprehensive_risk_profiler = comprehensive_risk_profiler
    @initial_investment = [comprehensive_risk_profiler.initial_investment, MINIMUM_INVESTMENT].max
  end

  def top_gold_etfs(limit)
    DataProvider::Scheme.where(:name.in => ['Goldman Sachs Gold Exchange Traded Scheme-Growth',
      'SBI Gold Exchange Traded Scheme-Growth', 'Kotak Gold ETF-Growth' ])
        .order_by([[:prev3_year_comp_percent, :desc]]).limit(limit)
  end

  def gold_investments
    return [] if gold_amount == 0

    if amount_greater_than_min_investment?(gold_amount / 2)
      top_gold_etfs(2).map{ |scheme| Hashie::Mash.new({:name => scheme.name, :amount => gold_amount/2, :percentage => asset_allocation['Gold']/2 }) }
    else
      top_gold_etfs(1).map { |scheme| Hashie::Mash.new({:name => scheme.name, :amount => gold_amount, :percentage => asset_allocation['Gold'] }) }
    end
  end

  def fixed_deposits
    top_two_fds = [ FixedDepositCollection.top_five_public_banks_interest_rates.first,
                  FixedDepositCollection.top_five_private_banks_interest_rates.first ]

    highest_interest_fd = top_two_fds.select { |fd| fd.one_year_interest_rate == top_two_fds.map(&:one_year_interest_rate).max }
    if amount_greater_than_min_investment?(fd_amount / 2)
      top_two_fds.map{ |fd| Hashie::Mash.new({:name => "Fixed Deposit at #{fd.name}", :amount => fd_amount/2, :percentage => asset_allocation['Fixed Deposits']/2 }) }
    else
      highest_interest_fd.map {|fd| Hashie::Mash.new({:name => "Fixed Deposit at #{fd.name}", :amount => fd_amount, :percentage => asset_allocation['Fixed Deposits'] }) }
    end
  end

  def distinct_schemes(schemes, limit)
    distinct_schemes = []
    growth_plan_code = 2066; dividend_plan_code = 2067
    schemes.group_by(&:code).each { |code,plans| distinct_schemes << ( plans.select{ |scheme| scheme.plan_code == growth_plan_code}.first ||
                                                  plans.select{ |scheme| scheme.plan_code == dividend_plan_code}.first ) }
    distinct_schemes.compact.take(limit)
  end

  def top_large_caps(limit)
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
    return [] if large_cap_amount == 0

    if amount_greater_than_min_investment?(large_cap_amount / 2)
      top_large_caps(2).map { |scheme| Hashie::Mash.new({:name => scheme.name, :amount => large_cap_amount/2, :percentage => asset_allocation['Large Cap Stocks']/2 }) }
    else
      top_large_caps(1).map { |scheme| Hashie::Mash.new({:name => scheme.name, :amount => large_cap_amount, :percentage => asset_allocation['Large Cap Stocks'] }) }
    end
  end

  def top_mid_caps(limit)
    mid_cap_schemes = DataProvider::Scheme.only(:code, :name, :plan_code, :minimum_investment_amount, :size, :entry_load, :exit_load, :prev3_year_comp_percent)
      .where(:bench_mark_index_name.in => ["CNX Midcap Index", "BSE Mid-Cap Index"])
        .where(:minimum_investment_amount.lte => 5000, :size.gte => 50 ).order_by([[:prev3_year_comp_percent, :desc]])
          .select{ |scheme| (scheme.entry_load.to_f + scheme.exit_load.to_f) <= 2 }.take(3 * limit)
    distinct_schemes(mid_cap_schemes, limit)
  end

  def mid_caps
    return [] if mid_cap_amount == 0

    if amount_greater_than_min_investment?(mid_cap_amount / 2)
      top_mid_caps(2).map { |scheme| Hashie::Mash.new({:name => scheme.name, :amount => mid_cap_amount/2, :percentage => asset_allocation['Mid Cap Stocks']/2 }) }
    else
      top_mid_caps(1).map { |scheme| Hashie::Mash.new({:name => scheme.name, :amount => mid_cap_amount, :percentage => asset_allocation['Mid Cap Stocks'] }) }
    end
  end

  def security_mix
    [fixed_deposits, gold_investments, large_caps, mid_caps].flatten.map{ |security|
      [ security.name, security.amount.to_f ] }
  end

  def public_security_mix
    [fixed_deposits, gold_investments, large_caps, mid_caps].flatten.map{ |security|
      [ security.name, security.percentage ] }
  end

  def scheme(name)
    DataProvider::Scheme.where(:name => name).first
  end

  def top_elss_funds
    DataProvider::Scheme.active.where(:class_code => 2119).order_by([[:prev3_year_comp_percent, :desc]])
  end

  def initial_investment=(amount)
    @initial_investment = [ IndianCurrency.new(amount), MINIMUM_INVESTMENT].max
  end

private
  def amount_greater_than_min_investment?(amount)
    amount > MINIMUM_AMOUNT_FOR_INVESTMENT
  end

  def gold_amount
    initial_investment * asset_allocation['Gold'] / 100
  end

  def fd_amount
    initial_investment * asset_allocation['Fixed Deposits'] / 100
  end

  def large_cap_amount
    initial_investment * asset_allocation['Large Cap Stocks'] / 100
  end

  def mid_cap_amount
    initial_investment * asset_allocation['Mid Cap Stocks'] / 100
  end

  def asset_allocation
    @asset_allocation ||= FinancialPlanner.ideal_asset_allocation(comprehensive_risk_profiler)
  end
end
