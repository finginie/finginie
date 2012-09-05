class ResponsesController < InheritedResources::Base
  actions :create, :index, :new

  def new
    session[:responses] = initialize_quiz_info
    flash[:about_quiz] = t('questions.quiz.about').html_safe
    flash[:question_number] = current_question_number
    redirect_to question_path(next_unanswered_question_id)
  end

  def index
    @responses = Response.new(session[:responses])
    authorize! :index, current_user
  end

  def collection
    session[:responses]
  end

  def create
    save params[:choice_id]
    if next_unanswered_question_id
      flash[:question_number] = current_question_number
      redirect_to question_path(next_unanswered_question_id)
    else
      redirect_to :action => "index"
    end
  end

private
  def save(choice_id)
    choice = Choice.find(choice_id)
    collection[choice.question_id] = choice_id
  end

  def next_unanswered_question_id
    collection.key Response::NOT_YET_ANSWERED
  end

  def current_question_number
    collection.keys.index(next_unanswered_question_id) + 1
  end

  def initialize_quiz_info
    Hash[Question.find(params[:question_ids].split('-')).map {|q| [q.id, Response::NOT_YET_ANSWERED]}]
  end

end