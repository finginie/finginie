class GoldTransactionsController < InheritedResources::Base
  belongs_to :portfolio

  def collection
    super.order("date DESC")
  end

  def create_resource(object)
    object.gold_id = Gold.first.id
    super
  end

  def create
    create!(:notice => "Gold transaction was successfully added") { details_portfolio_path(parent) }
  end
end
