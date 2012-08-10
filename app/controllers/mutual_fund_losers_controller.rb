class MutualFundLosersController < InheritedResources::Base
  actions :index

  def collection
    schemes = DataProvider::Scheme.active.equity_funds.where(:percentage_change.lt => 0).order([[ :percentage_change, :asc ]]).limit(5)
    SchemeDecorator.decorate(schemes)
  end
end
