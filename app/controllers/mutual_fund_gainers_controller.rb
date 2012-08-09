class MutualFundGainersController < InheritedResources::Base
  actions :index

  def collection
    schemes = DataProvider::Scheme.active.equity_funds.order([[ :percentage_change, :desc ]]).limit(params[:limit])
    SchemeDecorator.decorate(schemes)
  end
end
