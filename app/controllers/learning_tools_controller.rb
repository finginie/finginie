class LearningToolsController < InheritedResources::Base

  def index
    @review_questions = Question.review_questions(session[:learning_tools][:attempted_questions].keys)
    @user_responses = Choice.find(session[:learning_tools][:attempted_questions].values).group_by(&:id)
  end

  def start_quiz
    session_start
    redirect_to question_path(session[:learning_tools][:attempted_questions].first)
  end

private
  def session_start
    clear_session!(:learning_tools)
    session[:learning_tools]= {:attempted_questions => Question.random_question_ids,:score =>  0}
  end

end
