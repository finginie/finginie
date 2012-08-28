module PointTracker
  class CreatePortfolioAndAddTransactionStep < Base
    DESCRIPTION = 'Create Portfolio and add five transactions'
    ACTION_LINK = '/portfolios/new'
    POINTS      = 500

    def valid?
      !completed_step_for_user?
    end

    private
    def has_five_transactions?

    end
  end
end