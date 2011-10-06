class Transaction < ActiveRecord::Base
  belongs_to :net_position

  validates :date, :presence => true
  validate  :date_should_not_be_in_the_future
  validates :net_position_id, :presence => true, :unless => :net_position
  validates :quantity, :presence => true
  validates :price, :presence => true

private
  def date_should_not_be_in_the_future
    errors.add(:date, "can't be in the future") if !date.blank? and date > Date.today
  end
end
