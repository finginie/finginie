class LoanTransaction < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :loan

  validates_presence_of :price, :date, :portfolio_id
  validates_numericality_of :price

  validate  :date_should_not_be_in_the_future, :repay_amount_should_be_less_than_or_equal_to_amount

  accepts_nested_attributes_for :loan

  delegate *[:rate_of_interest, :period, :name], :to => :loan

  scope :for, lambda { |loan| where(:loan_id => loan).order(:date) } do
    def name
      first.name
    end

    def date
      first.date
    end

    def rate_of_interest
      first.rate_of_interest
    end

    def period
      first.period
    end

    def outstanding_amount
       first.loan.loan_transactions.count == 2 ? 0.0 : first.current_value
    end
  end

  def current_value(on_date = Date.today)
    time_period = (on_date.year - date.year) * 12 + (on_date.month - date.month) + 1
    emi = EmiCalculator.new(:cost => amount, :rate => rate_of_interest, :term => period).calculate_emi
    i = ( 1 + rate_of_interest / 1200)

    (- (amount * i ** time_period - emi.round * ( i ** time_period - 1) / (i - 1))).round(2)
  end

  def action
    (price < 0 ? :borrow : :repay) if price
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

  def loan
    super || build_loan
  end

private
  def set_price(amount, action)
    action ||= :borrow
    amount ||= 1
    self.price = { :repay => 1, :borrow => -1}[action.to_sym] * amount.to_i
  end

  def date_should_not_be_in_the_future
    errors.add(:date, "can't be in the future") if !date.blank? and date > Date.today
  end

  def repay_amount_should_be_less_than_or_equal_to_amount
    errors.add(:amount, "You only need Rs #{portfolio.loan_transactions.for(loan).outstanding_amount} to clear your loan") if action == :repay && portfolio.loan_transactions.for(loan).outstanding_amount.abs != amount
  end
end
