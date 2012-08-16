class QuestionsController < InheritedResources::Base
  before_filter :require_login_after_five_questions, :only => :show

  def show
    @question = Question.find(params[:id])
    @current_question_number = Question::QUIZLIMIT-Question.not_attempted_questions(session[:learning_tools][:attempted_questions]).size+1
  end

  def update
    @question = Question.find(params[:id])
    @score = score_update(@question.check_answer(params[:question][:choices].to_i))
    store_attempted_question(params[:id],params[:question][:choices])
    @next_question = Question.not_attempted_questions(session[:learning_tools][:attempted_questions]).first
    @next_question = 0 unless @next_question
    @score = 0 unless @score
  end

private

  def require_login_after_five_questions
    if Question.not_attempted_questions(session[:learning_tools][:attempted_questions]).size <= Question::LOGINLIMIT && !@current_user
     #redirect_to_login
      redirect_to "/auth/developer"
    end
  end

  def store_attempted_question(id,val)
    session[:learning_tools][:attempted_questions][id.to_i] = val
  end

  def score_update(result)
    if result
      session[:learning_tools][:score] = session[:learning_tools][:score]+1
      session[:learning_tools][:score]
    end
  end

end
