class PortfoliosController < InheritedResources::Base
  load_and_authorize_resource
  custom_actions :resource => [ :details, :transactions ]

  def resource
    PortfolioDecorator.decorate(super)
  end

protected
  def begin_of_association_chain
    @current_user
  end
end
