class PortfolioDecorator < ApplicationDecorator
  decorates :portfolio
  include Draper::LazyHelpers
  include NumberHelper

  #portfolio page asset_class wise percentages
  def stocks_percentage
    ( stocks_value / total_assets_value * 100).round(2).to_f
  end

  def mutual_funds_percentage
    ( mutual_funds_value / total_assets_value * 100).round(2).to_f
  end

  def gold_percentage
    ( gold_value / total_assets_value * 100).round(2).to_f
  end

  def fixed_deposits_percentage
   ( fixed_deposits_value / total_assets_value * 100).round(2).to_f
  end

  def real_estates_percentage
   ( real_estates_value / total_assets_value * 100).round(2).to_f
  end

  def total_assets_distribution
    [ [ "Stocks",         stocks_percentage        ],
      [ "Mutual Funds",   mutual_funds_percentage  ],
      [ "Gold",           gold_percentage          ],
      [ "Fixed Deposits", fixed_deposits_percentage],
      [ "Real Estates" ,  real_estates_percentage  ] ].select { |a| a.last != 0 }
  end

  #portfolio page networth calculations
  def assets_and_liabilities
    [ total_assets_value.to_f, total_liabilitites_value.to_f, net_worth.to_f ]
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
        :percentage => number_to_indian_currency(stocks_percentage),
        :amount     => number_to_indian_currency(stocks_value)
      },
      {
        :asset_type => "Mutual Funds",
        :percentage => number_to_indian_currency(mutual_funds_percentage),
        :amount     => number_to_indian_currency(mutual_funds_value)
      },
      {
        :asset_type => "Gold",
        :percentage => number_to_indian_currency(gold_percentage),
        :amount     => number_to_indian_currency(gold_value)
      },
      {
        :asset_type => "Fixed Deposits",
        :percentage => number_to_indian_currency(fixed_deposits_percentage),
        :amount     => number_to_indian_currency(fixed_deposits_value)
      },
      {
         :asset_type => "Real Estate" ,
         :percentage => number_to_indian_currency(real_estates_percentage),
         :amount     => number_to_indian_currency(real_estates_value)
      },
      {
        :asset_type => "Total Assets",
        :percentage => "100",
        :amount     => total_assets_value
      },
      {
        :asset_type => "Loans",
        :percentage => h.t('tables_not_available'),
        :amount     => total_liabilitites_value.abs
      },
      {
        :asset_type => "Total Liabilities",
        :percentage => h.t('tables_not_available'),
        :amount     => total_liabilitites_value.abs
      },
      {
        :asset_type => "Net Worth",
        :percentage => h.t('tables_not_available'),
        :amount     => net_worth }
      ]
  end

  #Analysis page items
  def sector_wise_stock_percentage
    stock_positions.group_by(&:sector).map { |sector, positions|  [ sector , ( positions.map(&:current_value).sum / stocks_value * 100).round(2).to_f ] }
  end

  def sector_wise_stock_percentage_table
    stock_positions.group_by(&:sector).map do |sector, positions|
      { :sector => sector, :amount_invested => positions.sum(&:current_value), :percentage => (positions.sum(&:current_value) / stocks_value * 100).round(2) }
    end
  end

  def stocks_positions_profit_or_loss
    companies.map { |company| Hashie::Mash.new({ :name => company.company_name, :type => 'Stock',
                                            :sector => company.industry_name,
                                            :profit_or_loss => (stock_transactions.for(company).profit_or_loss.round(2).to_f),
                                            :percentage => (stock_transactions.for(company).profit_or_loss_percentage.to_f)}) if !stock_transactions.for(company).sells.empty?}.compact
  end

  def category_wise_mutual_funds_percentage
    mutual_fund_positions.group_by(&:category).map { |category, positions| [ category, (positions.map(&:current_value).sum / mutual_funds_value * 100).round(2).to_f ] }
  end

  def category_wise_mutual_funds_percentage_table
    mutual_fund_positions.group_by(&:category).map do |category, positions|
      { :category => category, :amount_invested => positions.sum(&:current_value), :percentage => (positions.map(&:current_value).sum / mutual_funds_value * 100).round(2) }
    end
  end

  def mutual_fund_positions_profit_or_loss
    mutual_funds.map { |mf| Hashie::Mash.new({ :name => mf.name, :type => 'Mutual Fund',
                                               :category => mf.category,
                              :profit_or_loss => (mutual_fund_transactions.for(mf).profit_or_loss.round(2).to_f),
                              :percentage => (mutual_fund_transactions.for(mf).profit_or_loss_percentage.round(2).to_f) })  if !mutual_fund_transactions.for(mf).sells.empty? }.compact
  end

  def fixed_deposit_open_positions_rate_of_interests
    fixed_deposit_positions.map{ |fd| { :rate => fd.rate_of_interest.to_f, :name => fd.name, :amount => fd.invested_amount.to_f } }
  end

  def fixed_deposit_positions_profit_or_loss
    fixed_deposits.map { |fd| Hashie::Mash.new({ :name => fd.name, :type => 'Fixed Deposit',
                                                 :profit_or_loss => model.fixed_deposit_transactions.for(fd).profit_or_loss.to_f,
                                                 :percentage => model.fixed_deposit_transactions.for(fd).profit_or_loss_percentage.to_f }) if model.fixed_deposit_transactions.for(fd).profit_or_loss }.compact
  end

  def real_estate_positions_profit_or_loss
    real_estates.map { |re| Hashie::Mash.new( { :name => re.name, :type => 'Real Estate',
                                                :profit_or_loss => (model.real_estate_transactions.for(re.id).profit_or_loss.to_f),
                                                :percentage => model.real_estate_transactions.for(re.id).profit_or_loss_percentage.to_f} ) if model.real_estate_transactions.for(re.id).profit_or_loss }.compact
  end

  def gold_positions_profit_or_loss
    gold_transactions.for(Gold).profit_or_loss ? [Hashie::Mash.new( { :name => "Gold", :type => 'Gold',
                                                                      :profit_or_loss => (gold_transactions.for(Gold).profit_or_loss.to_f),
                                                                      :percentage => gold_transactions.for(Gold).profit_or_loss_percentage.to_f } )] : []
  end

  def positions
    stocks_positions_profit_or_loss + mutual_fund_positions_profit_or_loss +
        fixed_deposit_positions_profit_or_loss +
        real_estate_positions_profit_or_loss +
        gold_positions_profit_or_loss
  end

  def losses
    positions.select{ |position| position.profit_or_loss < 0 }
  end

  def profits
    positions.select{ |position| position.profit_or_loss > 0 }
  end

  def top_five_losses
    losses.sort_by(&:profit_or_loss).take(5)
  end

  def top_five_profits
    profits.sort_by(&:profit_or_loss).reverse.take(5)
  end

  def stock_transactions
    model.stock_transactions.reorder("date DESC")
  end

  def mutual_fund_transactions
    model.mutual_fund_transactions.reorder("date DESC")
  end

  def gold_transactions
    model.gold_transactions
  end

  def loan_transactions
    model.loan_transactions.reorder("date DESC")
  end

  def fixed_deposit_transactions
    model.fixed_deposit_transactions.reorder("date DESC")
  end

  def real_estate_transactions
    model.real_estate_transactions.reorder("date DESC")
  end
end
