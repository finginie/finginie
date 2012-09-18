class IdealInvestmentMix
  MINIMUM_INVESTMENT   = 30000
  INVESTMENT_THRESHOLD = 10000

  attr_reader :financial_planner, :investment_amount

  def initialize(financial_planner, amount)
    @financial_planner = financial_planner
    @investment_amount = IndianCurrency.new([amount, MINIMUM_INVESTMENT].max)
  end

  FinancialPlanner::ASSET_CLASSES.each do |asset_class|
    percent_method = "#{asset_class.singularize}_percent_per_investment"      ##
    define_method(percent_method) do                                          # def fixed_deposit_percent_per_investment
      asset_percent     = send("#{asset_class.singularize}_percent")          #   asset_percent = fixed_deposit_percent
      total_investments = send(asset_class).size                              #   total_investments = fixed_depoists.size
      asset_percent/total_investments                                         #   asset_percent / total_investments.size
    end                                                                       # end
                                                                              ##
    amount_method = "#{asset_class.singularize}_amount_per_investment"        ##
    define_method(amount_method) do                                           # def fixed_deposit_amount_per_investment
      asset_amount      = send("#{asset_class.singularize}_amount")           #   asset_amount = fixed_deposit_amount
      total_investments = send(asset_class).size                              #   total_investments = fixed_depoists.size
      asset_amount/total_investments                                          #   asset_amount / total_investments.size
    end                                                                       # end
  end                                                                         ##

  def fixed_deposits
    @fixed_deposits ||= begin
      top_two_fds = [ FixedDepositCollection.top_five_public_banks_interest_rates.first,
                      FixedDepositCollection.top_five_private_banks_interest_rates.first ].sort_by(&:one_year_interest_rate).reverse
      invest_in_one_or_two_assets(fixed_deposit_amount, top_two_fds)
    end
  end

  def gold
    return [] if gold_amount == 0
    @gold ||= begin
      top_2_gold_etfs = DataProvider::Scheme.top_gold_etfs.order_by_prev3_year_comp_percent.limit(2)
      invest_in_one_or_two_assets(gold_amount, top_2_gold_etfs)
    end
  end

  def large_cap_stocks
    return [] if large_cap_stock_amount == 0
    @large_cap_stocks ||= begin
      top_2_large_caps = DataProvider::Scheme.top_large_cap_stocks(2)
      invest_in_one_or_two_assets(large_cap_stock_amount, top_2_large_caps)
    end
  end

  def mid_cap_stocks
    return [] if mid_cap_stock_amount == 0
    @mid_cap_stocks ||= begin
      top_2_mid_caps = DataProvider::Scheme.top_mid_cap_stocks(2)
      invest_in_one_or_two_assets(mid_cap_stock_amount, top_2_mid_caps)
    end
  end

  def top_elss_funds
    DataProvider::Scheme.active.elss_funds.order_by_prev3_year_comp_percent
  end

  private
  def invest_in_one_or_two_assets(asset_amount, asset_investments)
    result = asset_amount > INVESTMENT_THRESHOLD ? asset_investments.take(2) : asset_investments.take(1)
    result.map(&:name)
  end

  FinancialPlanner::ASSET_CLASSES.each do |asset_class|
    percent_method = "#{asset_class.singularize}_percent"                     ##
    define_method(percent_method) do                                          # def fixed_deposit_percent
      financial_planner.send("#{asset_class}_percent").to_f                   #   financial_planner.fixed_depoists_percent.to_f
    end                                                                       # end
                                                                              ##
    amount_method = "#{asset_class.singularize}_amount"                       ##
    define_method(amount_method) do                                           # def fixed_deposit_amount
      investment_amount * send(percent_method)/100                            #   investment_amount * fixed_deposit_percent/100
    end                                                                       # end
  end
end