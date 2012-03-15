class MutualFundTransaction < ActiveRecord::Base
  belongs_to :portfolio
  belongs_to :mutual_fund

  accepts_nested_attributes_for :mutual_fund

  validates_presence_of :price, :quantity, :date
  validates_numericality_of :price, :quantity
  validate  :date_should_not_be_in_the_future, :sell_quantity_should_be_less_than_or_equal_to_quantity

  validates :mutual_fund_id, :presence => true, :unless => :mutual_fund

  scope :for, lambda { |name| joins(:mutual_fund).where("securities.name = ?", name).order(:date) } do
    def quantity
      sum(&:quantity)
    end

    def name
      first.mutual_fund.name
    end

    def category
      first.mutual_fund.category
    end

    def current_price
      first.mutual_fund.current_price
    end

    def current_value
      quantity * current_price
    end

    def buy_transactions
      all.select { |t|  t.quantity > 0 }
    end

    def sells
      all.select { |t| t.quantity < 0 }
    end

    def profit_or_loss
      sells.map { |t| - t.quantity * (t.price - average_price(t)) }.inject(:+)
    end

    def average_cost_price
      (all.map { |t| average_price(t) * t.quantity }.inject(:+) /quantity).round(2) if quantity > 0
    end

    def value
      average_cost_price * quantity
    end

    def prev_buy_transactions(transaction)
      buy_transactions.select { |t| t.date < transaction.date }
    end

    def average_price(transaction)
      price = ( transaction.quantity < 0 ) ?
        (prev_buy_transactions(transaction).map{ |t| t.price * t.quantity }.inject(:+) /prev_buy_transactions(transaction).sum(&:quantity) ) :
          transaction.price
    end

    def unrealised_profit
      current_value - value
    end
  end

  def profit_or_loss
    ( amount * ( price - MutualFundTransaction.for(mutual_fund.name).average_price(self) ) ) if quantity < 0
  end

  def value
    amount * price
  end

  def action
    (quantity < 0 ? :sell : :buy) if quantity
  end

  def action=(action)
    set_quantity(amount, action)
    action
  end

  def amount
    quantity && quantity.abs
  end

  def amount=(amount)
    set_quantity(amount, action)
    amount
  end

  def mutual_fund
    super || build_mutual_fund
  end

private
  def set_quantity(amount, action)
    action ||= :buy
    amount ||= 1
    self.quantity = { :buy => 1, :sell => -1}[action.to_sym] * amount.to_i
  end

  def date_should_not_be_in_the_future
    errors.add(:date, "can't be in the future") if !date.blank? and date > Date.today
  end

  def sell_quantity_should_be_less_than_or_equal_to_quantity
    errors.add(:amount, "Your portfolio do not have sufficient number of mutual funds for this action") if action == :sell && portfolio.mutual_fund_transactions.for(mutual_fund.name).quantity < amount
  end
end
