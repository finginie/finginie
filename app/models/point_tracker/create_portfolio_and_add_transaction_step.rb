module PointTracker
  class CreatePortfolioAndAddTransactionStep < Base
    DESCRIPTION = 'Create Portfolio and add five transactions'
    ACTION_LINK = { :controller => 'portfolios', :action => 'new' }
    POINTS      = 500

    def valid?
      !completed_step_for_user? && has_more_than_four_transactions?
    end

    private
    def has_more_than_four_transactions?
      portfolio = Portfolio.find(meta_data[:portfolio_id])

      portfolio.all_transactions.size > 4
    end
  end
end
