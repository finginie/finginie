class QuizSummaryDecorator < ApplicationDecorator
  attr_reader :quiz_summary, :number, :news, :choices, :text, :reason, :status

  def initialize(quiz_summary, index)
    @quiz_summary  = quiz_summary
    @number        = index + 1
    @news          = quiz_summary.question.news
    @choices       = quiz_summary.question.choices
    @text          = quiz_summary.question.text
    @reason        = quiz_summary.question.reason
    @status        = quiz_summary.question_status
  end

  def question_summary
    h.content_tag(:div, :id => get_div_id) do
      question_news +
      question_text +
      choices_list  +
      question_reason
    end
  end

private


  def get_div_id
    "bs-quiz-answer-#{status}"
  end

  def question_news
    h.content_tag(:h3, news)
  end

  def question_text
    h.content_tag(:h3, "Question #{number} : #{text}")
  end

  def choices_list
    list_of_choices = ActiveSupport::SafeBuffer.new
    h.content_tag(:ol, :id => "choices_order_list") do
      choices.each do |choice|
        list_of_choices << choice_list_item(choice)
      end
      list_of_choices
    end
  end

  def choice_list_item(choice)
    h.content_tag(:li) do
      h.content_tag(:span, choice.text) +
      h.content_tag(:span, '', {:id => get_span_id(choice)})
    end
  end

  def get_span_id(choice)
    if (choice.id == quiz_summary.question.correct_choice_id )
      choice.id == quiz_summary.user_choice_id ? 'icon_question_correct_answer' : 'icon_question_correctanswer'
    elsif (choice.id == quiz_summary.user_choice_id)
      'icon_question_incorrect'
    end
  end

  def question_reason
    h.content_tag('h2', 'Explanation') + h.content_tag(:p, reason)
  end


end
