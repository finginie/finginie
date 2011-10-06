class Security < ActiveRecord::Base
  include StiHelper

  belongs_to :user
  has_many :net_positions

  validates :name, :presence => true
end
