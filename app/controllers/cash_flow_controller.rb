class CashFlowController < InheritedResources::Base
  defaults :singleton => true
  actions :show

  def resource
    @search = DataProvider::Company.new
    @company = DataProvider::Company.find_by_slug(params[:stock_id] )
    @cash_flows = DataProvider::CashFlow.all(conditions: { company_code: @company.code }, sort: [[ :year_ending, :desc ]], limit: 5)
    @cash_flows = CashFlowCollectionDecorator.new(@cash_flows)
  end
end
