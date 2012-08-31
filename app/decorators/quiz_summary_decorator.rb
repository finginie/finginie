class QuizSummaryDecorator < ApplicationDecorator
  attr_reader :quiz_summary, :question_number

  def initialize(quiz_summary, index)
    @quiz_summary    = quiz_summary
    @question_number = index + 1
  end

  def table_rows
    summary_row + explanation_row
  end

  private
  def summary_row
    h.content_tag(:tr, :class => get_summary_class) do
      question_number_td +
      question_text_td   +
      user_response_td   +
      correct_answer_td
    end
  end

  def explanation_row
    h.content_tag(:tr) do
      explanation_info_td
    end
  end

  def get_summary_class
    quiz_summary.question_status ? 'success' : 'error'
  end

  def question_number_td
    h.content_tag(:td, question_number)
  end

  def question_text_td
    h.content_tag(:td, quiz_summary.question_text)
  end

  def user_response_td
    h.content_tag(:td, quiz_summary.user_choice)
  end

  def correct_answer_td
    h.content_tag(:td, quiz_summary.correct_answer)
  end

  def explanation_info_td
    h.content_tag(:td, { :colspan => 4 }) { "Explanation: #{quiz_summary.question_explanation}" }
  end
end
