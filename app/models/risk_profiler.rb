class RiskProfiler < ActiveRecord::Base
  attr_accessible :score
  belongs_to :quiz
  belongs_to :user
  has_many :responses, :dependent => :destroy

  accepts_nested_attributes_for :responses, :reject_if => lambda { |a| a[:choice_id].blank? }

  def to_param
    quiz && quiz.slug
  end

  def questions
    responses.map{|r| r.question}
  end

  def build_responses
    (quiz.questions - questions).each {|question| responses.build :question => question }
    self
  end
end
