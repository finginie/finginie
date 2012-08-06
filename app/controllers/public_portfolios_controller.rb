class PublicPortfoliosController < InheritedResources::Base
  before_filter :create_public_portfolio, :only => :create
  load_and_authorize_resource
  actions :show, :create
  defaults :resource_class => Portfolio

private
  def create_public_portfolio
    @public_portfolio = Portfolio.find(params[:id])
    @public_portfolio.make_public!
  end
end
