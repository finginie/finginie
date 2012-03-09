class LoanTransactionsController < InheritedResources::Base
  belongs_to :portfolio
  custom_actions :resource => [ :clear ]

  def clear
    resource.loan.repay(resource)
    clear!{ redirect_to details_portfolio_url(@portfolio), :notice => "Successfully cleared the loan" and return }
  end
end
