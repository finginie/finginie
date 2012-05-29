class CashFlowController < InheritedResources::Base
  defaults :singleton => true
  actions :show

  def resource
    @search = Company.new
    @company = Company.find_by_name(params[:stock_id] )
    @cash_flows = CashFlow.all(conditions: { company_code: @company.code }, sort: [[ :year_ending, :desc ]], limit: 5)
    @cash_flows = CashFlowCollectionDecorator.new(@cash_flows)
  end
end
