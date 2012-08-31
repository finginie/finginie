class LearningTool
  QUIZ_LIMIT  = 3
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
    quiz_info.keys.index(question_id) + 1
  end

  def score
    user_choice_ids    = quiz_info.values
    correct_choice_ids = quiz_info.keys.map{|question_id| Question.find(question_id).correct_choice_id}

    (user_choice_ids & correct_choice_ids).size
  end

  def next_question_id
    quiz_info.key(NOT_YET_ANSWERED)
  end

  def quiz_data
    questions.inject([]) do |result, question|
      result << Hashie::Mash.new({
        :question_text  => question.text,
        :correct_answer => question.correct_answer_text,
        :user_choice  => user_choices[question.id].first.text,
        :reason => question.reason
      })
      result
    end
  end

  private
  def questions
    Question.find(quiz_info.keys, :include => :correct_answer)
  end

  def user_choices
    Choice.find(quiz_info.values).group_by(&:question_id)
  end
end