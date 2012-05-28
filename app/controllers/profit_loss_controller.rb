class ProfitLossController < InheritedResources::Base
  defaults :singleton => true
  actions :show

  def resource
    @search = Company.new
    @company = Company.find_by_code(params[:stock_id])
    @audited_results = AuditedResult.all(conditions: { company_code: params[:stock_id] }, sort: [[ :year_ending, :desc ]], limit: 5)
    @audited_results = AuditedResultDecorator.decorate(@audited_results)
  end
end
