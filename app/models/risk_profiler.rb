class RiskProfiler < ActiveRecord::Base
  attr_accessible :score, :responses_attributes, :quiz
  belongs_to :quiz
  belongs_to :financial_planner
  has_many :responses, :dependent => :destroy

  validates :quiz_id, :presence => true
  accepts_nested_attributes_for :responses, :reject_if => lambda { |a| a[:choice_id].blank? }
  before_save :clean_responses
  before_save :calculate_score

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

private
  def clean_responses
    responses.delete_if {|r| !r.choice_id}
  end

  def calculate_score
    self.score = send(quiz.result_type) if responses.length == quiz.questions.length
  end

  def mean
   result = [ responses.map{|r| r.choice.score * r.question.weight }.inject(:+) / quiz.questions.sum(:weight)]
   result = (result + responses.map{|r| r.choice.ceiling}.reject{ |c| c.nil? }).min
  end

  def mode
    responses
      .group_by { |r| r.choice.score }
      .sort_by { |k, v| v.map {|r| r.choice.question.weight}.inject(:+) }
      .last.first
  end
end
