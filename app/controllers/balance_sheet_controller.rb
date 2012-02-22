class BalanceSheetController < InheritedResources::Base
  actions :show

  def show
    @stock = Stock.find(params[:stock_id])
    if @stock.company_code
      @audited_results = AuditedResult.all(conditions: { companycode: @stock.company_code }, sort: [[ :year_ending, :desc ]], limit: 5)
      @audited_results = AuditedResultDecorator.decorate(@audited_results)
    end
  end

end
