class FixedDepositTransaction < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :fixed_deposit

  validates_presence_of :price, :date, :portfolio_id
  validates_numericality_of :price
  validate  :date_should_not_be_in_the_future

  accepts_nested_attributes_for :fixed_deposit

  delegate *[:rate_of_interest, :period, :name], :to => :fixed_deposit

  scope :for, lambda { |fixed_deposit_name| joins(:fixed_deposit).where("securities.name = ?", fixed_deposit_name).order(:date) } do

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
    if action == :sell
     time_period = [ (date - portfolio.fixed_deposit_transactions.for(name).first.date)/365, period ].min
     (fixed_deposit.send(:value_at_date, amount, time_period) - amount).round(2)
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

  def action
    (price < 0 ? :sell : :buy) if price
  end
  def action=(action)
    set_price(amount, action)
    action
  end

  def amount
    price && price.abs
  end
  def amount=(amount)
    set_price(amount, action)
    amount
  end

  def fixed_deposit
    super || build_fixed_deposit
  end

private
  def set_price(amount, action)
    action ||= :buy
    amount ||= 1
    self.price = { :buy => 1, :sell => -1}[action.to_sym] * amount.to_i
  end

  def date_should_not_be_in_the_future
    errors.add(:date, "can't be in the future") if !date.blank? and date > Date.today
  end
end
