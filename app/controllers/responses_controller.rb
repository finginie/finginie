class ResponsesController < InheritedResources::Base
  actions :create, :index, :new

  def new
    session[:responses] = initialize_quiz_info
    flash[:info] = t('quiz.about').html_safe
    flash[:question_number] = current_question_number
    redirect_to question_path(next_unanswered_question_id)
  end

  def index
    @responses = Response.new(session[:responses])
    flash[:about_quiz] = t('quiz.reason_to_signup').html_safe unless current_user
    authorize! :index, current_user
  end

  def collection
    session[:responses]
  end

  def create
    save params
    if next_unanswered_question_id
      flash[:question_number] = current_question_number
      flash[:error] = t('quiz.error_message') unless params[:choice_id]
      redirect_to question_path(next_unanswered_question_id)
    else
      redirect_to :action => "index"
    end
  end

private
  def save(params)
    collection[params[:question_id].to_i]= params[:choice_id]
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