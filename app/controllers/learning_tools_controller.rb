class LearningToolsController < InheritedResources::Base
  actions :index
  before_filter :require_login_to_show_quiz_review, :only => :index

  def collection
    @learning_tool = LearningTool.new(session[:learning_tools][:quiz_info])
  end

  def start_quiz
    clear_session!(:learning_tools)
    session[:learning_tools] = { :quiz_info => LearningTool.initialize_quiz_info}
    first_question = session[:learning_tools][:quiz_info].first
    redirect_to question_path(first_question)
  end

  def require_login_to_show_quiz_review
    if !logged_in?
      redirect_to_login
    end
  end

end
