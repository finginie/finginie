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
    create! { portfolio_path(parent) }
  end
end
