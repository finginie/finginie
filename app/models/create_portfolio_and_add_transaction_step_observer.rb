class CreatePortfolioAndAddTransactionStepObserver < ActiveRecord::Observer
  observe Portfolio::TRANSACTION_TYPES

  def after_create(model)
    portfolio = model.portfolio
    user      = portfolio.user
    meta_data = { :portfolio_id => portfolio.id }
    PointTracker::CreatePortfolioAndAddTransactionStep.new(user, meta_data).save
  end
end