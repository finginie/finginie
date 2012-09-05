module PointTracker
  class SharePortfolioOnTwitterStep < Base
    DESCRIPTION = 'Share Portfolio on Twitter'
    ACTION_LINK = { :controller => :ideal_investments, :action => :show }
    POINTS      = 200
  end
end