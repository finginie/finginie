class QuestionsController < InheritedResources::Base
  custom_actions :resource => :update_response
  before_filter :get_question, :only => [:show, :update_response]
#  before_filter :require_login_after_five_questions, :only => :show

  def show
    @current_question_number = @learning_tool.question_number(@question.id)
  end

  def update_response
    user_response = params[:question][:user_response_id].to_i
    session[:learning_tools][:quiz_info][@question.id] = user_response

    @learning_tool = LearningTool.new(session[:learning_tools][:quiz_info])
    next_question = @learning_tool.next_question_id
    redirect_to next_question ? question_path(next_question) : learning_tools_path
  end

  private
  def get_question
    @question = Question.find(params[:id])
    @learning_tool = LearningTool.new(session[:learning_tools][:quiz_info])
  end


  # def require_login_after_five_questions
  #   @learning_tool = LearningTool.new(session[:learning_tools][:quiz_info])
  #   if !logged_in? && @learning_tool.exceeded_quiz_limit?
  #     redirect_to_login
  #   end
  # end
end
