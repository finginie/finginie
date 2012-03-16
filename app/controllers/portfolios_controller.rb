class PortfoliosController < InheritedResources::Base
  load_and_authorize_resource
  custom_actions :resource => [ :details, :transactions, :stocks_analysis, :mutual_funds_analysis, :fixed_deposits_analysis, :accumulated_profits, :add_transaction ]

  def resource
    PortfolioDecorator.decorate(super)
  end

protected
  def begin_of_association_chain
    @current_user
  end
end
