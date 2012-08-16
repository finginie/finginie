class Portfolio < ActiveRecord::Base
  TRANSACTION_TYPES = [
    :stock_transaction,
    :gold_transaction,
    :mutual_fund_transaction,
    :loan_transaction,
    :fixed_deposit_transaction,
    :real_estate_transaction
  ]
  attr_accessible :name

  belongs_to :user
  has_many :subscriptions, :as => :subscribable

  has_many :stock_transactions,         :dependent => :destroy
  has_many :mutual_fund_transactions,   :dependent => :destroy
  has_many :gold_transactions,          :dependent => :destroy
  has_many :loan_transactions,          :dependent => :destroy
  has_many :fixed_deposit_transactions, :dependent => :destroy
  has_many :real_estate_transactions,   :dependent => :destroy

  has_many :mutual_funds,   :through => :mutual_fund_transactions,   :uniq => true
  has_many :loans,          :through => :loan_transactions,          :uniq => true
  has_many :fixed_deposits, :through => :fixed_deposit_transactions, :uniq => true
  has_many :real_estates,   :through => :real_estate_transactions,   :uniq => true

  scope :public, where(:is_public => true)

  validates :user_id, :presence => true
  validates :name, :presence => true,
                  :uniqueness => { :scope => :user_id }

  after_destroy :clear_create_portfolio_and_add_transaction_step

  def all_transactions
    TRANSACTION_TYPES.inject([]) do |result, transaction|
      result << send(transaction.to_s.pluralize)
    end.flatten
  end

  def companies
    stock_transactions.map(&:company).uniq.compact
  end

  def stock_positions
    companies.map { |company|  stock_transactions.for(company) }.select{ |position| position.quantity != 0}
  end

  def mutual_fund_positions
    mutual_funds.map { |mutual_fund| mutual_fund_transactions.for(mutual_fund) }.select{ |position| position.quantity != 0}
  end

  def loan_positions
    loans.map { |loan|  loan_transactions.for(loan) if loan.loan_transactions.count == 1  } - [ nil ]
  end

  def fixed_deposit_positions
    fixed_deposits.map { |fixed_deposit|  fixed_deposit_transactions.for(fixed_deposit) if fixed_deposit.fixed_deposit_transactions.count == 1 } - [ nil ]
  end

  def real_estate_positions
    real_estates.map { |real_estate|  real_estate_transactions.for(real_estate) if real_estate.real_estate_transactions.count == 1 } - [ nil ]
  end

  def total_liabilitites_value
    (loan_positions.sum(IndianCurrency.new(0),&:outstanding_amount))
  end

  def total_assets_value
    ( stocks_value + mutual_funds_value + gold_value + fixed_deposits_value + real_estates_value )
  end

  def net_worth
    total_assets_value + total_liabilitites_value
  end

  def stocks_value
    stock_positions.sum(IndianCurrency.new(0),&:current_value)
  end

  def mutual_funds_value
    mutual_fund_positions.sum(IndianCurrency.new(0),&:current_value)
  end

  def gold_value
    gold_transactions.for(DataProvider::Gold).current_value
  end

  def real_estates_value
    real_estate_positions.sum(IndianCurrency.new(0),&:current_value)
  end

  def fixed_deposits_value
    fixed_deposit_positions.sum(IndianCurrency.new(0),&:current_value)
  end

  def make_public!
    update_attribute :is_public, true
  end

  def make_private!
    update_attribute :is_public, false
  end

  private
  def clear_create_portfolio_and_add_transaction_step
    CompletedStep.where("meta_data -> 'portfolio_id' = '#{self.id}'").destroy_all
  end
end
