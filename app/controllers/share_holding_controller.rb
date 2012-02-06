class ShareHoldingController < InheritedResources::Base
  actions :show

  def show
    @stock = Stock.find(params[:stock_id])
    @share_holding = ShareHolding.all(conditions: { company_code: @stock.company_code }, sort: [[ :share_holding_date, :desc ]], limit: 1).first
    @share_holding = ShareHoldingDecorator.decorate(@share_holding)
  end
end
