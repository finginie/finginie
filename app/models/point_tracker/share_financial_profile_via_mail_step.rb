module PointTracker
  class ShareFinancialProfileViaMailStep < Base
    DESCRIPTION = 'Share Financial Profile Via EMail'
    ACTION_LINK = { :controller => 'ideal_investments', :action => 'show' }
    POINTS      = 50
  end
end