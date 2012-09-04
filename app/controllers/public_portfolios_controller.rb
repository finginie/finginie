class PublicPortfoliosController < InheritedResources::Base
  before_filter :create_public_portfolio, :only => :create
  actions :show, :create, :destroy
  defaults :resource_class => Portfolio
  custom_actions :resource => [ :current_holdings, :profit_loss, :historical_transactions]
  authorize_resource :class => false

  def end_of_association_chain
    super.public
  end

  def resource
    PortfolioDecorator.decorate(super)
  end

private
  def create_public_portfolio
    @public_portfolio = Portfolio.find(params[:id])
    @public_portfolio.make_public!
  end

  def destroy_resource(object)
    object.make_private!
  end
end
