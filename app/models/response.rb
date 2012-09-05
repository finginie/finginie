class Response
  QUIZ_LIMIT  = 20
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
      correct_answer  = question.correct_answer_text
      user_response   = user_choices[question.id].first.text
      result << OpenStruct.new({
        :question_text        => question.text,
        :correct_answer       => correct_answer,
        :user_choice          => user_response,
        :question_explanation => question.reason,
        :question_status      => correct_answer == user_response
      })
      result
    end
  end

  private
  def questions
    Question.questions_with_correct_answers(question_ids)
  end

  def question_ids
    quiz_info.keys
  end

  def user_choice_ids
    quiz_info.values.map(&:to_i)
  end

  def user_choices
    Choice.find(user_choice_ids).group_by(&:question_id)
  end
end
