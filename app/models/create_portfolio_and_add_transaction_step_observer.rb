class CreatePortfolioAndAddTransactionStepObserver < ActiveRecord::Observer
  TRANSACTION_TYPES = [:stock_transaction, :gold_transaction, :mutual_fund_transaction, :loan_transaction, :fixed_deposit_transaction, :real_estate_transaction]
  observe TRANSACTION_TYPES

  def after_create(model)
    portfolio = model.portfolio

    all_transactions = []
    TRANSACTION_TYPES.each do |transaction_type|
      all_transactions << portfolio.send(transaction_type.to_s.pluralize)
    end

    if all_transactions.flatten.size > 4
      PointTracker::CreatePortfolioAndAddTransactionStep.new(portfolio.user).save
    end
    binding.pry
  end
end
