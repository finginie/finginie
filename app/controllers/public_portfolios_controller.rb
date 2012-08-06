class PublicPortfoliosController < InheritedResources::Base
  before_filter :create_public_portfolio, :only => :create
  load_and_authorize_resource
  actions :show, :create
  defaults :resource_class => Portfolio
  custom_actions :resource => [ :current_holdings, :profit_loss, :historical_transactions]

  def resource
    PortfolioDecorator.decorate(super)
  end

private
  def create_public_portfolio
    @public_portfolio = Portfolio.find(params[:id])
    @public_portfolio.make_public!
  end
end
