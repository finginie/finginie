module PointTracker
  class ShareFinancialProfileOnTwitterStep < Base
    DESCRIPTION = 'Share Personalized financial profile results on Twitter'
    ACTION_LINK = { :controller => 'ideal_investments', :action => 'show' }
    POINTS      = 200
  end
end