class BalanceSheetController < InheritedResources::Base
  defaults :singleton => true
  actions :show

  def resource
    @search = Company.new
    @audited_results = AuditedResult.all(conditions: { companycode: params[:stock_id] }, sort: [[ :year_ending, :desc ]], limit: 5)
    @audited_results = AuditedResultDecorator.decorate(@audited_results)
  end

end
