class PortfolioDecorator < ApplicationDecorator
  decorates :portfolio

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
end
