class PortfolioDecorator < ApplicationDecorator
  decorates :portfolio
  include Draper::LazyHelpers
  include NumberHelper

  #portfolio page asset_class wise percentages
  def stocks_percentage
    number_to_indian_currency(( stocks_value / total_assets_value * 100).round(2))
  end

  def mutual_funds_percentage
    number_to_indian_currency(( mutual_funds_value / total_assets_value * 100).round(2))
  end

  def gold_percentage
    number_to_indian_currency(( gold_value / total_assets_value * 100).round(2))
  end

  def fixed_deposits_percentage
   number_to_indian_currency(( fixed_deposits_value / total_assets_value * 100).round(2))
  end

  def real_estates_percentage
   number_to_indian_currency(( real_estates_value / total_assets_value * 100).round(2))
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

  def empty_transactions?
    stocks_value == 0 && mutual_funds_value == 0 && gold_value == 0 && real_estates_value == 0 && fixed_deposits_value == 0
  end

  def total_assets_distribution_table
    [
      {
        :asset_type => "Stocks",
        :percentage => stocks_percentage,
        :amount     => number_to_indian_currency(stocks_value) },
      {
        :asset_type => "Mutual Funds",
        :percentage => mutual_funds_percentage,
        :amount     => number_to_indian_currency(mutual_funds_value) },
      {
        :asset_type => "Gold",
        :percentage => gold_percentage,
        :amount     => number_to_indian_currency(gold_value) },
      {
        :asset_type => "Fixed Deposits",
        :percentage => fixed_deposits_percentage,
        :amount     => number_to_indian_currency(fixed_deposits_value)},
      {
         :asset_type => "Real Estate" ,
         :percentage => real_estates_percentage,
         :amount     => number_to_indian_currency(real_estates_value) }
      ]
  end

  #Analysis page items
  def sector_wise_stock_percentage
    stock_positions.group_by(&:sector).map { |sector, positions|  [ sector , ( positions.map(&:current_value).sum / stocks_value * 100).round(2).to_f ] }
  end

  def stocks_positions_profit_or_loss
    stocks.map { |stock| [ stock.name, number_to_indian_currency(stock_transactions.for(stock).sell_transactions.map(&:profit_or_loss).sum.round(2).to_f) ] if !stock_transactions.for(stock).sell_transactions.empty?} - [nil]
  end

  def category_wise_mutual_funds_percentage
    mutual_fund_positions.group_by(&:category).map { |category, positions| [ category, (positions.map(&:current_value).sum / mutual_funds_value * 100).round(2).to_f ] }
  end

  def mutual_fund_positions_profit_or_loss
    mutual_funds.map(&:name).uniq.map { |mf_name| [ mf_name, number_to_indian_currency(mutual_fund_transactions.for(mf_name).sell_transactions.map(&:profit_or_loss).sum.round(2).to_f) ] }
  end

  def fixed_deposit_open_positions_rate_of_interests
    fixed_deposit_positions.map{ |fd| [ fd.rate_of_interest.to_f, fd.invested_amount.to_f ] }
  end

  def fixed_deposit_positions_profit_or_loss
    fixed_deposits.map(&:name).uniq.map { |fd_name| [fd_name, number_to_indian_currency(fixed_deposit_transactions.for(fd_name).profit_or_loss) ] if fixed_deposit_transactions.for(fd_name).profit_or_loss } - [nil]
  end

  def real_estate_positions_profit_or_loss
    real_estates.map { |re| [ re.name, number_to_indian_currency(real_estate_transactions.for(re.id).profit_or_loss.to_f) ] if real_estate_transactions.for(re.id).profit_or_loss } - [nil]
  end

  def gold_positions_profit_or_loss
    gold_transactions.profit_or_loss ? [[ "Gold", number_to_indian_currency(gold_transactions.profit_or_loss)]] : []
  end

  def positions
    stocks_positions_profit_or_loss + mutual_fund_positions_profit_or_loss +
        fixed_deposit_positions_profit_or_loss +
        real_estate_positions_profit_or_loss +
        gold_positions_profit_or_loss
  end

  def top_five_losses
    positions.select{ |position| position.last.to_f < 0 }.sort_by(&:last).take(5)
  end

  def top_five_profits
    positions.select{ |position| position.last.to_f > 0 }.sort_by(&:last).reverse.take(5)
  end
end
