class CreatePortfolioAndAddTransactionStepObserver < ActiveRecord::Observer
  observe Portfolio::TRANSACTION_TYPES

  def after_create(model)
    portfolio = model.portfolio
    user      = portfolio.user
    meta_data = { :portfolio_id => portfolio.id }
    pt_obj    = PointTracker::CreatePortfolioAndAddTransactionStep.new(user, meta_data)
    pt_obj.save
  end
end