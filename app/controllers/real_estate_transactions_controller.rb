class RealEstateTransactionsController < InheritedResources::Base
  belongs_to :portfolio

  custom_actions :resource => [ :sell, :create_sell ]

  def collection
    super.order("date DESC")
  end

  def create
    create! { portfolio_path(parent) }
  end

  def create_sell
    params[:real_estate_transaction].delete "id"
    object = build_resource
    create_resource(object)
    create_sell!{ redirect_to details_portfolio_path(parent), :notice => "Successfully sell your property" and return }
  end
end
