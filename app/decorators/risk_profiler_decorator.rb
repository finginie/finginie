class RiskProfilerDecorator < ApplicationDecorator
  decorates :risk_profiler
  include Draper::LazyHelpers

  def score
    score = model.score ? ( model.quiz.buckets ? (model.quiz.buckets.scan(/[\w]+/)[model.score.to_i]) : (model.score.round(1).to_f )) : nil

    markup = (score ? content_tag(:p, "Your score is #{score}") : content_tag(:p, "Complete this quiz to view your score"))
    markup += tag(:div, :id => "#{model.quiz.slug}-chart", data: { :horizontal_pie_chart => "[6,#{score},10]" } ) if score

    markup
  end

  def name
    model.quiz.name
  end

end
