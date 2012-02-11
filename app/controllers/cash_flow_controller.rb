class CashFlowController < InheritedResources::Base
  actions :show

  def show
    @stock = Stock.find(params[:stock_id])
    if @stock.company_code
      @cash_flows = CashFlow.all(conditions: { company_code: @stock.company_code }, sort: [[ :year_ending, :desc ]], limit: 5)
      @cash_flows = CashFlowCollectionDecorator.new(@cash_flows)
    end
  end
end
