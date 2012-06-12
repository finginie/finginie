class GoldTransaction < ActiveRecord::Base
  belongs_to :portfolio

  scope :for, lambda { |gold| order('date, created_at') } do
    include GoldPosition
  end

  def gold
    DataProvider::Gold
  end
  alias :security :gold

  include FungibleTransaction
end
