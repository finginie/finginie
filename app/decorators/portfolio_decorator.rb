class PortfolioDecorator < ApplicationDecorator
  decorates :portfolio

  #portfolio page asset_class wise percentages
  def stocks_percentage
    ( stocks_value / total_assets_value * 100).round(2)
  end

  def mutual_funds_percentage
    ( mutual_funds_value / total_assets_value * 100).round(2)
  end

  def gold_percentage
    ( gold_value / total_assets_value * 100).round(2)
  end

  def fixed_deposits_percentage
    ( fixed_deposits_value / total_assets_value * 100).round(2)
  end

  def real_estates_percentage
    ( real_estates_value / total_assets_value * 100).round(2)
  end

  def total_assets_distribution
    [ [ "Stocks", stocks_percentage], ["Mutual Funds", mutual_funds_percentage], ["Gold", gold_percentage], ["Fixed Deposits", fixed_deposits_percentage], ["Real Estates" , real_estates_percentage]]
  end

  #portfolio page networth calculations
  def assets_and_liabilities
    [ total_assets_value, total_liabilitites_value, net_worth ]
  end

  def assets_and_liabilities?
    total_assets_value != 0 || total_liabilitites_value != 0 || net_worth != 0
  end

  def total_assets_distribution_table
    [
      {
        :asset_type => "Stocks",
        :percentage => stocks_percentage,
        :amount     => stocks_value },
      {
        :asset_type => "Mutual Funds",
        :percentage => mutual_funds_percentage,
        :amount     => mutual_funds_value },
      {
        :asset_type => "Gold",
        :percentage => gold_percentage,
        :amount     => gold_value },
      {
        :asset_type => "Fixed Deposits",
        :percentage => fixed_deposits_percentage,
        :amount     => fixed_deposits_value},
      {
         :asset_type => "Real Estate" ,
         :percentage => real_estates_percentage,
         :amount     => real_estates_value }
      ]
  end

  #Analysis page items
  def sector_wise_stock_percentage
    stock_positions.group_by(&:sector).map { |sector, positions|  [ sector , ( positions.map(&:current_value).sum / stocks_value * 100).round(2).to_f ] }
  end

  def stocks_positions_profit_or_loss
    stocks.map { |stock| [ stock.name, stock_transactions.for(stock).sell_transactions.map(&:profit_or_loss).sum.round(2).to_f ] if !stock_transactions.for(stock).sell_transactions.empty?} - [nil]
  end

  def category_wise_mutual_funds_percentage
    mutual_fund_positions.group_by(&:category).map { |category, positions| [ category, (positions.map(&:current_value).sum / mutual_funds_value * 100).round(2).to_f ] }
  end

  def mutual_fund_positions_profit_or_loss
    mutual_funds.map(&:name).uniq.map { |mf_name| [ mf_name, mutual_fund_transactions.for(mf_name).sell_transactions.map(&:profit_or_loss).sum.round(2).to_f ] }
  end

  def fixed_deposit_open_positions_rate_of_interests
    fixed_deposit_positions.map{ |fd| [ fd.rate_of_interest.to_f, fd.invested_amount.to_f ] }
  end
end
