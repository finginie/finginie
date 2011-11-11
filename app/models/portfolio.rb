class Portfolio < ActiveRecord::Base
  belongs_to :user

  has_many :net_positions

  validates :user_id, :presence => true
  validates :name, :presence => true,
                  :uniqueness => { :scope => :user_id }

  def net_worth
    net_positions.map(&:current_value).inject(:+)
  end
end
