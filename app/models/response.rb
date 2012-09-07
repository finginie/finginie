class Response
  QUIZ_LIMIT  = 10
  NOT_YET_ANSWERED  = nil

  attr_reader :quiz_info

  def initialize(quiz_info)
    @quiz_info = quiz_info
  end

  def score
    correct_choice_ids = questions.map(&:correct_choice_id)
    (user_choice_ids & correct_choice_ids).size
  end

  def summary
    questions.inject([]) do |result, question|
      correct_answer  = question.correct_choice_id
      user_choice_id   = quiz_info[question.id].to_i
      result << OpenStruct.new({
        :question             => question,
        :question_status      => correct_answer == user_choice_id,
        :user_choice_id          => user_choice_id
      })
      result
    end
  end

  private
  def questions
    Question._with_choices(question_ids)
  end

  def question_ids
    quiz_info.keys
  end

  def user_choice_ids
    quiz_info.values.map(&:to_i)
  end

end
