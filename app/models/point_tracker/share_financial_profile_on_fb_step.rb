module PointTracker
  class ShareFinancialProfileOnFbStep < Base
    DESCRIPTION = 'Share Personalized financial profile results on FaceBook'
    ACTION_LINK = { :controller => :ideal_investments, :action => :show }
    POINTS      = 200
  end
end