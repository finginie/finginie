class CashFlowController < InheritedResources::Base
  defaults :singleton => true
  actions :show

  def resource
    @search = Company.new
    @company = Company.find_by_code(params[:stock_id])
    @cash_flows = CashFlow.all(conditions: { company_code: params[:stock_id] }, sort: [[ :year_ending, :desc ]], limit: 5)
    @cash_flows = CashFlowCollectionDecorator.new(@cash_flows)
  end
end
