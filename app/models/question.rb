class Question < ActiveRecord::Base
  attr_accessible :text, :weight, :news, :reason ,:correct_choice_id

  LOGINLIMIT = 5
  QUIZLIMIT = 10

  has_many :choices, :dependent => :destroy

  validates :text, :presence => true

  belongs_to :correct_answer, :foreign_key => 'correct_choice_id', :class_name => 'Choice'

  scope:review_questions, lambda { |questions| includes(:correct_answer).find(questions)}

  def check_answer(response)
    correct_choice_id == response
  end

  def self.random_question_ids
    questions=Question.find(:all, :order => 'random()',:select=>'id',:limit=> QUIZLIMIT)
    random_question_hash = {}
    questions.each do |question|
      random_question_hash[question.id] = nil
    end
    random_question_hash
  end

  def self.not_attempted_questions(questions)
    questions.select {|k,v| v == nil}
  end

end
