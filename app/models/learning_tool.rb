class LearningTool
  QUIZ_LIMIT  = 20
  NOT_YET_ANSWERED  = nil

  attr_reader :quiz_info

  def self.initialize_quiz_info
    Question.random_questions.inject({}) do |result, question|
      result[question.id] = NOT_YET_ANSWERED
      result
    end
  end

  def initialize(quiz_info)
    @quiz_info = quiz_info
  end

  def question_number(question_id)
    question_ids.index(question_id) + 1
  end

  def score
    correct_choice_ids = questions.map(&:correct_choice_id)
    (user_choice_ids & correct_choice_ids).size
  end

  def next_question_id
    quiz_info.key(NOT_YET_ANSWERED)
  end

  def quiz_summary
    questions.inject([]) do |result, question|
      correct_answer  = question.correct_answer_text
      user_response   = user_choices[question.id].first.text
      result << Hashie::Mash.new({
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
    quiz_info.values
  end

  def user_choices
    Choice.find(user_choice_ids).group_by(&:question_id)
  end
end