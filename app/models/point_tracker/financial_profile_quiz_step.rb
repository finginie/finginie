module PointTracker
  class FinancialProfileQuizStep < Base
    DESCRIPTION = 'Take Personalized financial profile quiz'
    ACTION_LINK = { :controller => 'comprehensive_risk_profilers', :action => 'edit' }
    POINTS      = 50

    def valid?
      !completed_step_for_user? && user_taken_quiz?
    end

    private
    def user_taken_quiz?
      quiz = ComprehensiveRiskProfiler.find meta_data[:quiz_id]
      quiz.valid?
    end
  end
end