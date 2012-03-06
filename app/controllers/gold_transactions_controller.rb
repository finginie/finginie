class GoldTransactionsController < InheritedResources::Base
  belongs_to :portfolio

  def collection
    super.order("date DESC")
  end

  def resource
    super.gold = Gold.first
    super
  end
end
