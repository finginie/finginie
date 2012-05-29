class ProfitLossController < InheritedResources::Base
  defaults :singleton => true
  actions :show

  def resource
    @search = Company.new
    @company = Company.find_by_name(params[:stock_id] )
    @audited_results = AuditedResult.all(conditions: { company_code: @company.code }, sort: [[ :year_ending, :desc ]], limit: 5)
    @audited_results = AuditedResultDecorator.decorate(@audited_results)
  end
end
