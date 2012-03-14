class StockTransactionsController < InheritedResources::Base
  belongs_to :portfolio

  def collection
    super.order("date DESC")
  end

  def create
    create! { portfolio_path(parent) }
  end
end
