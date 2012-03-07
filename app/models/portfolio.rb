class Portfolio < ActiveRecord::Base
  belongs_to :user

  has_many :net_positions
  has_many :stock_transactions
  has_many :mutual_fund_transactions
  has_many :gold_transactions, :order => :date, :extend => GoldPosition
  has_many :loan_transactions

  has_many :stocks, :through => :stock_transactions, :uniq => true
  has_many :mutual_funds, :through => :mutual_fund_transactions, :uniq => true
  has_many :loans, :through => :loan_transactions, :uniq => true


  validates :user_id, :presence => true
  validates :name, :presence => true,
                  :uniqueness => { :scope => :user_id }

  def stock_positions
    stocks.map { |stock|  stock_transactions.for(stock) } if stocks
  end

  def mutual_fund_positions
    mutual_funds.map(&:name).uniq.map { |name| mutual_fund_transactions.for(name) } if mutual_funds
  end

  def loan_positions
    loans.map { |loan|  loan_transactions.for(loan) if loan.loan_transactions.count == 1  } - [ nil ] if loans
  end

  def net_worth
    net_positions.map(&:current_value).inject(:+)
  end

  def net_worth_except_loan
    net_positions_by_security_type.map { |type, net_positions| net_positions.map(&:current_value).inject(:+) unless type =="Loan" }.compact.inject(:+)
  end

  def net_worth_security_share
    net_positions_by_security_type.map { |type, net_positions| [type,(net_positions.map(&:current_value).inject(:+).to_f/net_worth_except_loan * 100).round(2)] unless type =="Loan" }.compact
  end

  def net_positions_by_security_type
    net_positions.group_by { |net_position| net_position.security.type }
  end
end
