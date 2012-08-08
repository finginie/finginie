class TradeAccount < ActiveRecord::Base
  belongs_to :user
  attr_accessible :address, :city, :name, :phone_number, :special_requirements

  validates_presence_of :user_id, :address, :city, :name, :phone_number
  validates_uniqueness_of :user_id
end
