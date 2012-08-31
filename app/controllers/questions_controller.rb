class QuestionsController < InheritedResources::Base
  actions :show
  before_filter :get_question, :only => [:show, :update_response]

  def show
    learning_tool = get_learning_tool_from_session
    @current_question_number = learning_tool.question_number(@question.id)
  end

  def update_response
    update_user_response_in_session
    learning_tool = get_learning_tool_from_session #this needs to be called after updating session

    next_question = learning_tool.next_question_id
    redirect_to next_question ? question_path(next_question) : learning_tools_path
  end

  private
  def get_learning_tool_from_session
    LearningTool.new(session[:learning_tools][:quiz_info])
  end

  def get_question
    @question = Question.find(params[:id])
  end

  def update_user_response_in_session
    user_response = params[:question][:user_response_id].to_i
    session[:learning_tools][:quiz_info][@question.id] = user_response
  end
end
