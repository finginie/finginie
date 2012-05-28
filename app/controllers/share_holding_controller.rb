class ShareHoldingController < InheritedResources::Base
  defaults :singleton => true
  actions :show

  def resource
    @search = Company.new
    @company = Company.find_by_code(params[:stock_id])
    @share_holding = ShareHolding.all(conditions: { company_code: params[:stock_id] }, sort: [[ :share_holding_date, :desc ]], limit: 1).first
    @share_holding = ShareHoldingDecorator.decorate(@share_holding)
  end
end
