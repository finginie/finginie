class CashFlowController < InheritedResources::Base
  belongs_to :stock, :singleton => true
  actions :show

  def resource
    @search = Stock.search
    if parent.company_code
      @cash_flows = CashFlow.all(conditions: { company_code: parent.company_code }, sort: [[ :year_ending, :desc ]], limit: 5)
      @cash_flows = CashFlowCollectionDecorator.new(@cash_flows)
    end
  end
end
