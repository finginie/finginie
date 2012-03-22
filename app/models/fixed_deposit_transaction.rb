class FixedDepositTransaction < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :fixed_deposit

  validates_presence_of :date, :portfolio_id
  validates :price, :numericality => {:greater_than => 0}, :presence => true
  validate  :date_should_not_be_in_the_future, :redemption_date_should_be_greater_than_deposit_date

  accepts_nested_attributes_for :fixed_deposit

  delegate *[:rate_of_interest, :period, :name, :rate_of_redemption], :to => :fixed_deposit

  scope :for, lambda { |fixed_deposit| where(:fixed_deposit_id => fixed_deposit).order(:date) } do

    def name
      first.name
    end

    def rate_of_interest
      first.rate_of_interest
    end

    def period
      first.period
    end

    def invested_amount
      first.invested_amount
    end

    def current_value
      first.current_value
    end

    def unrealised_profit
      (current_value - first.amount).round(2)
    end

    def profit_or_loss
      last.profit_or_loss if all.count == 2
    end
  end

  def profit_or_loss
    if action.to_sym == :sell
     time_period = [ (date - portfolio.fixed_deposit_transactions.for(fixed_deposit).first.date)/365, period ].min
     (fixed_deposit.send(:value_at_date, price, time_period, rate_of_redemption) - price).round(2)
    end
  end

  def current_value
    fixed_deposit.current_value(self).round(2)
  end

  def invested_amount
    price
  end

  def interest
    (current_value - invested_amount).round(2)
  end

  def amount
    action.to_sym == :buy ? price : (price * -1)
  end

  def fixed_deposit
    super || build_fixed_deposit
  end

  def display_action
    action.to_sym == :buy ? "Deposit" : "Redeem"
  end

private
  def date_should_not_be_in_the_future
    errors.add(:date, "can't be in the future") if !date.blank? and date > Date.today
  end

  def redemption_date_should_be_greater_than_deposit_date
    if action.to_sym == :sell
      errors.add(:date, "can't redeem before the deposit date") if date < portfolio.fixed_deposit_transactions.for(fixed_deposit).first.date
    end
  end
end
