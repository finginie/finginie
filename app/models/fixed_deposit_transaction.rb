class FixedDepositTransaction < ActiveRecord::Base
  include CurrencyFormatter
  attr_accessible :date, :comments, :price, :action, :portfolio_id, :fixed_deposit_id, :fixed_deposit_attributes
  belongs_to :portfolio
  belongs_to :fixed_deposit

  validates_presence_of :date, :portfolio_id
  validates :price, :numericality => {:greater_than => 0}, :presence => true
  validate  :date_should_not_be_in_the_future, :redemption_date_should_be_greater_than_deposit_date
  validates :comments, :length => { :maximum => 75 }

  accepts_nested_attributes_for :fixed_deposit

  delegate :rate_of_interest, :period, :name, :rate_of_redemption, :to => :fixed_deposit
  monetize :price

  scope :for, lambda { |fixed_deposit| where(:fixed_deposit_id => fixed_deposit).order(:date, :created_at) } do
    delegate :name, :rate_of_interest, :period, :invested_amount, :current_value, :to => :first

    def unrealised_profit
      (current_value - first.amount)
    end

    def unrealised_profit_percentage
      (unrealised_profit / invested_amount * 100).round(2)
    end

    def profit_or_loss
      last.profit_or_loss if count == 2
    end

    def profit_or_loss_percentage
      (profit_or_loss * 100/ invested_amount).round(2).to_f
    end
  end

  def profit_or_loss
    (fixed_deposit.send(:value_at_date, price, time_period, redemption_interest_rate) - price) if sell?
  end

  def current_value
    fixed_deposit.current_value(self)
  end

  def invested_amount
    price
  end

  def interest
    (current_value - invested_amount).round(2)
  end

  def amount
    buy? ? price : (price * -1)
  end

  def fixed_deposit
    super || build_fixed_deposit
  end

  def display_action
    buy? ? "Deposit" : "Redeem"
  end

  def sell?
    action && action.downcase.to_sym == :sell
  end

  def buy?
    action && action.downcase.to_sym == :buy
  end

private
  def redemption_interest_rate
    rate_of_redemption || rate_of_interest
  end

  def time_period
    [ (date - portfolio.fixed_deposit_transactions.for(fixed_deposit).first.date)/365, period ].min
  end

  def date_should_not_be_in_the_future
    errors.add(:date, "can't be in the future") if !date.blank? and date > Date.today
  end

  def redemption_date_should_be_greater_than_deposit_date
    if sell?
      errors.add(:date, "can't redeem before the deposit date") if date < portfolio.fixed_deposit_transactions.for(fixed_deposit).first.date
    end
  end
end
