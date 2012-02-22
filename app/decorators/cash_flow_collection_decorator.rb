class CashFlowCollectionDecorator
  def initialize(cash_flows)
    @cash_flow_decorators = CashFlowDecorator.decorate(cash_flows)
  end

  def collection_non_null_fields
    @cash_flow_decorators.map { |decorator| decorator.non_null_fields }.flatten.uniq - [ "company_code", "year_ending", "months", "type", "_id" ]
  end
end
