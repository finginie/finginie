class Security < ActiveRecord::Base
  include StiHelper

  attr_accessible :type, :name, :current_price

  belongs_to :user
  has_many :net_positions

  validates :name, :presence => true
end
