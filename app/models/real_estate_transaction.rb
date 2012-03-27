class RealEstateTransaction < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :real_estate

  validates_presence_of :date, :portfolio_id, :action
  validates :price, :numericality => {:greater_than => 0}, :presence => true
  validate  :date_should_not_be_in_the_future, :sell_date_should_be_greater_than_buy_date
  validates :comments, :length => { :maximum => 75 }

  accepts_nested_attributes_for :real_estate

  delegate :name, :to => :real_estate

  scope :for, lambda { |real_estate| where(:real_estate_id => real_estate).order(:date, :created_at) } do

    def name
      first.name
    end

    def buy_value
      first.price
    end

    def current_value
      first.current_value
    end

    def unrealised_profit
      (current_value - buy_value)
    end

    def profit_or_loss
      last.profit_or_loss if all.count == 2
    end

    def profit_or_loss_percentage
      ( profit_or_loss * 100 / buy_value ).round(2)
    end
  end

  def profit_or_loss
    if action.to_sym == :sell
      price - portfolio.real_estate_transactions.for(real_estate).buy_value
    end
  end

  def current_value
    real_estate.current_value(self)
  end

  def percentage_change
    ((current_value - price).to_f / price * 100).round(2)
  end

  def real_estate
    super || build_real_estate
  end

  def amount
    action.to_sym == :buy ? price : (price * -1)
  end

private
  def date_should_not_be_in_the_future
    errors.add(:date, "can't be in the future") if !date.blank? and date > Date.today
  end

  def sell_date_should_be_greater_than_buy_date
    if action && action.to_sym == :sell
      errors.add(:date, "can't sell before the buy date") if date < portfolio.real_estate_transactions.for(real_estate).first.date
    end
  end

end
