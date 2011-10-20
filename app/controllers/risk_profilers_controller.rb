class RiskProfilersController < InheritedResources::Base
  actions :show, :update
  def resource
    @quiz = Quiz.find_by_slug(params[:id])
    @risk_profiler = RiskProfiler.find_or_initialize_by_user_id_and_quiz_id(current_user.id, @quiz.id).build_responses
  end
end
