module FungibleTransaction
  extend ActiveSupport::Concern

  included do
    attr_accessible :action, :quantity, :price, :date, :comments

    scope :buys, where(:action => ['buy', 'Buy'])
    scope :sells, where(:action => ['sell', 'Sell'])
    scope :before, lambda { |transaction|
      where('date < :date or ( date = :date and created_at < :created_at )',
          :date => transaction.date,
          :created_at => transaction.created_at || DateTime.now
          ).order(:date, :created_at)
    }

    validates_presence_of :date
    validate  :date_should_not_be_in_the_future, :sell_quantity_should_be_less_than_or_equal_to_quantity

    validates :action,  :presence => true,
                        :inclusion => {:in => ['buy', 'sell', 'Buy', 'Sell']}
    validates :price, :numericality => {:greater_than => 0}, :presence => true
    validates :quantity, :numericality => {:greater_than => 0}, :presence => true
    validates :comments, :length => { :maximum => 75 }
  end

  def profit_or_loss
    @profit_or_loss ||= buy? ? 0 : quantity * ( price - adjusted_average_price )
  end

  def value
    quantity * price
  end

  def adjusted_average_price
    @average_price ||= buy? ? ((similar_transactions.value + value) / (similar_transactions.quantity + quantity)).round(2) : similar_transactions.average_cost_price
  end

  def buy?
    action && action.downcase.to_sym == :buy
  end

  def sell?
    action && action.downcase.to_sym == :sell
  end

  def amount
    buy? ? quantity : -quantity
  end

private
  def similar_transactions
    @similar_transactions ||= portfolio.send(self.class.name.underscore.pluralize).for(security).before(self)
  end

  def date_should_not_be_in_the_future
    errors.add(:date, "can't be in the future") if !date.blank? and date > Date.today
  end

  def sell_quantity_should_be_less_than_or_equal_to_quantity
    errors.add(:quantity, "Your portfolio does not have sufficient #{security.class.name.pluralize.underscore.humanize} for this action") if sell? && similar_transactions.quantity < quantity
  end
end

