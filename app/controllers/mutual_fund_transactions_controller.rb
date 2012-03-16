class MutualFundTransactionsController < InheritedResources::Base
  belongs_to :portfolio

  def collection
    super.order("date DESC")
  end

  def create
    create!(:notice => "Mutual Fund transaction was successfully added") { details_portfolio_path(parent)}
  end
end
