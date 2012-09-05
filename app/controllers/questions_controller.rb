class QuestionsController < InheritedResources::Base
  actions :show, :index

  def collection
  	Question.random_questions
  end

  def index
  	redirect_to new_response_path(:question_ids => collection.map(&:id).join('-'))
  end
end
