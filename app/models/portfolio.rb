class Portfolio < ActiveRecord::Base
  belongs_to :user

  has_many :net_positions

  validates :user_id, :presence => true
  validates :name, :presence => true,
                  :uniqueness => { :scope => :user_id }

  def net_worth
    net_positions.map(&:current_value).inject(:+)
  end

  def net_worth_except_loan
    net_positions_by_security_type.map { |type, net_positions| net_positions.map(&:current_value).inject(:+) unless type =="Loan" }.compact.inject(:+)
  end

  def net_worth_security_share
      net_positions_by_security_type.map { |type, net_positions| [type,(net_positions.map(&:current_value).inject(:+).to_f/net_worth_except_loan * 100).round(2)] unless type =="Loan" }.compact
  end

  def net_positions_by_security_type
    net_positions.group_by { |net_position| net_position.security.type }
  end
end
