class RiskProfilersController < InheritedResources::Base
  actions :show, :update

  def resource
    @quiz = Quiz.find_by_slug(params[:id])
    @financial_planner = FinancialPlanner.find_or_create_by_user_id(current_user.id)
    @risk_profiler = @financial_planner.risk_profilers.find_or_initialize_by_quiz_id(@quiz.id).build_responses
  end

  def update
    update!(:notice => "You have answered #{resource.responses.length} out of #{resource.quiz.questions.length}.Your responses have been saved successfully. Answer all questions to view your score") { financial_planner_url }
  end
end
