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

private
  def gold_amount
    initial_investment * asset_allocation['Gold'] / 100
  end

  def fd_amount
    initial_investment * asset_allocation['Fixed Deposits'] / 100
  end

  def initial_investment
    [comprehensive_risk_profiler.initial_investment, IndianCurrency.new(30000)].max
  end

  def asset_allocation
    @asset_allocation ||= FinancialPlanner.ideal_asset_allocation(comprehensive_risk_profiler)
  end
end
