class BiggestMutualFundsController < InheritedResources::Base
  actions :index

  def collection
    schemes = DataProvider::Scheme.active.equity_funds.order([[ :size, :desc ]]).limit(5)
    SchemeDecorator.decorate(schemes)
  end
end
