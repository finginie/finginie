class RiskProfiler < ActiveRecord::Base
  attr_accessible :score
  belongs_to :quiz
  belongs_to :user

  def to_param
    quiz && quiz.slug
  end
end
