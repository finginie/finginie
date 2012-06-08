class PortfolioDecorator < ApplicationDecorator
  decorates :portfolio
  include Draper::LazyHelpers
  include NumberHelper

  def stock_positions
    model.stock_positions.map { |position| FungiblePositionDecorator.custom_decorate(position) }
  end

  def mutual_fund_positions
    model.mutual_fund_positions.map { |position| FungiblePositionDecorator.custom_decorate(position) }
  end

  def gold_position
    FungiblePositionDecorator.custom_decorate(resource.gold_transactions.for(DataProvider::Gold))
  end

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

  def total_liabilitites_percentage
    total_liabilitites_value < 0 ? 100 : 0
  end

  def total_assets_distribution
    [ [ "Stocks",         stocks_percentage        ],
      [ "Mutual Funds",   mutual_funds_percentage  ],
      [ "Gold",           gold_percentage          ],
      [ "Fixed Deposits", fixed_deposits_percentage],
      [ "Real Estate" ,   real_estates_percentage  ] ].select { |a| a.last != 0 }
  end

  #portfolio page networth calculations
  def assets_and_liabilities
    [ [ 'Type',        'Value'                       ],
      [ 'Assets',      total_assets_value.to_f       ],
      [ 'Liabilities', total_liabilitites_value.to_f ],
      [ 'NetWorth',    net_worth.to_f                ] ]
  end

  def assets_and_liabilities?
    total_assets_value != 0 || total_liabilitites_value != 0 || net_worth != 0
  end

  def empty_transactions?
    stock_transactions.empty? && mutual_fund_transactions.empty? &&
      gold_transactions.empty? && real_estate_transactions.empty? &&
      fixed_deposit_transactions.empty? && loan_transactions.empty?
  end

  def empty_positions?
    stock_positions.empty? && mutual_fund_positions.empty? &&
        gold_transactions.empty? && real_estate_positions.empty? &&
        fixed_deposit_positions.empty? && loan_positions.empty?
  end

  def total_assets_distribution_table
    [
      {
        :asset_type => "Stocks",
        :percentage => number_to_indian_currency(stocks_percentage),
        :amount     => number_to_indian_currency(stocks_value,0)
      },
      {
        :asset_type => "Mutual Funds",
        :percentage => number_to_indian_currency(mutual_funds_percentage),
        :amount     => number_to_indian_currency(mutual_funds_value,0)
      },
      {
        :asset_type => "Gold",
        :percentage => number_to_indian_currency(gold_percentage),
        :amount     => number_to_indian_currency(gold_value,0)
      },
      {
        :asset_type => "Fixed Deposits",
        :percentage => number_to_indian_currency(fixed_deposits_percentage),
        :amount     => number_to_indian_currency(fixed_deposits_value,0)
      },
      {
         :asset_type => "Real Estate" ,
         :percentage => number_to_indian_currency(real_estates_percentage),
         :amount     => number_to_indian_currency(real_estates_value,0)
      },
      {
        :asset_type => "Total",
        :class      => "total",
        :amount     => number_to_indian_currency(total_assets_value,0)}
      ]
  end

  def total_liabilities_distribution_table
    [
      {
        :asset_type => "Loans",
        :percentage => number_to_indian_currency(total_liabilitites_percentage),
        :amount     => number_to_indian_currency(total_liabilitites_value.abs,0)
      },
      {
        :asset_type => "Total",
        :class      => "total",
        :amount     => number_to_indian_currency(total_liabilitites_value.abs,0)
      },
      {
        :asset_type => "Net Worth",
        :class      => "total",
        :amount     => number_to_indian_currency(net_worth,0)}
    ]
  end

  #Analysis page items
  def sector_wise_stock_percentage
    stock_positions.group_by(&:sector).map { |sector, positions|  [ sector , ( positions.map(&:current_value).sum / stocks_value * 100).round(2).to_f ] }
  end

  def sector_wise_stock_percentage_table
    category_wise_fungible_position_table(stock_positions.group_by(&:sector), stocks_value)
  end

  def stocks_positions_profit_or_loss
    companies.map { |company|
                              stock_positions = stock_transactions.for(company)
                              Hashie::Mash.new({ :name => company.name, :type => 'Stock',
                                            :sector => company.industry_name,
                                            :average_sell_price => stock_positions.average_sell_price,
                                            :average_cost_price => stock_positions.average_cost_price,
                                            :quantity => stock_positions.sells.quantity.abs,
                                            :profit_or_loss => (stock_positions.profit_or_loss.round(2).to_f),
                                            :percentage => (stock_positions.profit_or_loss_percentage.to_f)}) if !stock_positions.sells.empty?}.compact
  end

  def category_wise_mutual_funds_percentage
    mutual_fund_positions.group_by(&:category).map { |category, positions| [ category, (positions.map(&:current_value).sum / mutual_funds_value * 100).round(2).to_f ] }
  end

  def category_wise_mutual_funds_percentage_table
    category_wise_fungible_position_table(mutual_fund_positions.group_by(&:category), mutual_funds_value)
  end

  def mutual_fund_positions_profit_or_loss
    mutual_funds.map { |mf|
                            mutual_fund_positions = mutual_fund_transactions.for(mf)
                            Hashie::Mash.new({ :name => mf.name, :type => 'Mutual Fund',
                                               :category => mf.category,
                                               :average_sell_price => mutual_fund_positions.average_sell_price,
                                               :average_cost_price => mutual_fund_positions.average_cost_price,
                                               :quantity => mutual_fund_positions.sells.quantity.abs,
                              :profit_or_loss => (mutual_fund_positions.profit_or_loss.round(2).to_f),
                              :percentage => (mutual_fund_positions.profit_or_loss_percentage.round(2).to_f) })  if !mutual_fund_positions.sells.empty? }.compact
  end

  def fixed_deposit_open_positions_rate_of_interests
    fixed_deposit_positions.map{ |fd| Hashie::Mash.new({ :rate => fd.rate_of_interest.to_f, :name => fd.name, :amount => fd.invested_amount.to_f }) }
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
    gold_transactions.for(DataProvider::Gold).profit_or_loss ? [Hashie::Mash.new( { :name => "Gold", :type => 'Gold',
                                                                      :average_sell_price => gold_transactions.for(DataProvider::Gold).average_sell_price,
                                                                      :average_cost_price => gold_transactions.for(DataProvider::Gold).average_cost_price,
                                                                      :quantity           => gold_transactions.for(DataProvider::Gold).sells.quantity.abs,
                                                                      :profit_or_loss     => (gold_transactions.for(DataProvider::Gold).profit_or_loss.to_f),
                                                                      :percentage         => gold_transactions.for(DataProvider::Gold).profit_or_loss_percentage.to_f } )] : []
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

  def net_profit_or_loss
    positions.map(&:profit_or_loss).sum.round(2)
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

private
  def category_wise_fungible_position_table(fungible_position, fungible_value)
    fungible_position.map do |category, positions|
      fungible_position_under_each_category = [
                                          Hashie::Mash.new({ name: category, current_value: positions.sum(&:current_value),
                                                             percentage: (positions.map(&:current_value).sum / fungible_value * 100).round(2),
                                                             class_name: "name"
                                                           })
                                        ]
      fungible_position_under_each_category << positions.map do |position|
        Hashie::Mash.new({ name: position.name, quantity: position.quantity, average_cost_price: position.average_cost_price,
                           amount_invested: position.value, current_price: position.current_price, current_value: position.current_value,
                           unrealised_profit: position.unrealised_profit, percentage: (position.current_value / fungible_value * 100).round(2)})
      end
      fungible_position_under_each_category.flatten
    end
  end
end
