class Portfolio < ActiveRecord::Base
  belongs_to :user

  has_many :net_positions
  has_many :stock_transactions
  has_many :mutual_fund_transactions
  has_many :gold_transactions, :order => :date, :extend => GoldPosition
  has_many :loan_transactions
  has_many :fixed_deposit_transactions
  has_many :real_estate_transactions

  has_many :stocks, :through => :stock_transactions, :uniq => true
  has_many :mutual_funds, :through => :mutual_fund_transactions, :uniq => true
  has_many :loans, :through => :loan_transactions, :uniq => true
  has_many :fixed_deposits, :through => :fixed_deposit_transactions, :uniq => true
  has_many :real_estates, :through => :real_estate_transactions, :uniq => true


  validates :user_id, :presence => true
  validates :name, :presence => true,
                  :uniqueness => { :scope => :user_id }

  def stock_positions
    stocks.map { |stock|  stock_transactions.for(stock) }
  end

  def mutual_fund_positions
    mutual_funds.map(&:name).uniq.map { |name| mutual_fund_transactions.for(name) }
  end

  def loan_positions
    loans.map { |loan|  loan_transactions.for(loan) if loan.loan_transactions.count == 1  } - [ nil ]
  end

  def fixed_deposit_positions
    fixed_deposits.map(&:name).uniq.map { |name|  fixed_deposit_transactions.for(name) if FixedDeposit.where(:name => name).count == 1 } - [ nil ]
  end

  def real_estate_positions
    real_estates.map { |real_estate|  real_estate_transactions.for(real_estate) if real_estate.real_estate_transactions.count == 1 } - [ nil ]
  end

  def total_liabilitites_value
    (loan_positions.map(&:outstanding_amount).sum).round(2)
  end

  def total_assets_value
    ( stocks_value + mutual_funds_value + gold_value + fixed_deposits_value + real_estates_value ).round(2)
  end

  def net_worth
    total_assets_value + total_liabilitites_value
  end

  def stocks_value
    stock_positions.map(&:current_value).sum
  end

  def mutual_funds_value
    mutual_fund_positions.map(&:current_value).sum
  end

  def gold_value
    gold_transactions.current_value
  end

  def real_estates_value
    real_estate_positions.map(&:current_value).sum
  end

  def fixed_deposits_value
    fixed_deposit_positions.map(&:current_value).sum
  end

end
