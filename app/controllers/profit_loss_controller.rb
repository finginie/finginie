class ProfitLossController < InheritedResources::Base
  belongs_to :stock, :singleton => true
  actions :show

  def resource
    if parent.company_code
      @audited_results = AuditedResult.all(conditions: { companycode: parent.company_code }, sort: [[ :year_ending, :desc ]], limit: 5)
      @audited_results = AuditedResultDecorator.decorate(@audited_results)
    end
  end
end