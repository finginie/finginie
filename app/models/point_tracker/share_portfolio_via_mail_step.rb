module PointTracker
  class SharePortfolioViaMailStep < Base
    DESCRIPTION = 'Share Financial Profile Via EMail'
    ACTION_LINK = { :controller => :ideal_investments, :action => :show }
    POINTS      = 100
  end
end