class ComprehensiveRiskProfilersController < InheritedResources::Base
  defaults :singleton => true
  actions :edit, :update

  def update
    financial_quiz_creator = FinancialQuizCreator.new(self, params[:comprehensive_risk_profiler])
    if financial_quiz_creator.create_for(current_user)
      redirect_to comprehensive_risk_profiler_ideal_investments_path, :notice =>t(".comprehensive_risk_profilers.success_message")
    else
      session[:comprehensive_risk_profiler] = params[:comprehensive_risk_profiler]
      redirect_to login_and_go_to(comprehensive_risk_profiler_ideal_investments_path)
    end
  end

  def resource
    @comprehensive_risk_profiler ||= current_user && current_user.comprehensive_risk_profiler || ComprehensiveRiskProfiler.new(session[:comprehensive_risk_profiler])
    ComprehensiveRiskProfilerDecorator.decorate(@comprehensive_risk_profiler)
  end
end
