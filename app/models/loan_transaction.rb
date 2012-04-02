class LoanTransaction < ActiveRecord::Base
  attr_accessible :portfolio_id, :loan_id, :price, :date, :action, :loan_attributes, :comments

  belongs_to :portfolio
  belongs_to :loan

  validates_presence_of :date, :portfolio_id
  validates :price, :numericality => {:greater_than => 0}, :presence => true
  validates :action,  :presence => true,
                      :inclusion => {:in => ['borrow', 'repay', 'Borrow', 'Repay']}

  validate  :date_should_not_be_in_the_future, :repay_amount_should_be_less_than_or_equal_to_amount
  validates :comments, :length => { :maximum => 75 }

  accepts_nested_attributes_for :loan

  delegate *[:rate_of_interest, :period, :name], :to => :loan

  scope :for, lambda { |loan| where(:loan_id => loan).order(:date, :created_at) } do
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

  def borrow?
    action && action.downcase.to_sym == :borrow
  end

  def repay?
    action && action.downcase.to_sym == :repay
  end

  def current_value(on_date = Date.today)
    time_period = (on_date.year - date.year) * 12 + (on_date.month - date.month) + 1
    emi = EmiCalculator.new(:cost => price, :rate => rate_of_interest, :term => period).calculate_emi
    i = ( 1 + rate_of_interest / 1200)

    (- (price * i ** time_period - emi.round * ( i ** time_period - 1) / (i - 1))).round(2)
  end

  def amount
    repay? ? price : (price * -1)
  end

  def loan
    super || build_loan
  end

private
  def date_should_not_be_in_the_future
    errors.add(:date, "can't be in the future") if !date.blank? and date > Date.today
  end

  def repay_amount_should_be_less_than_or_equal_to_amount
    errors.add(:quantity, "You only need Rs #{portfolio.loan_transactions.for(loan).outstanding_amount} to clear your loan") if repay? && portfolio.loan_transactions.for(loan).outstanding_amount.abs != price
  end
end
