class Question < ActiveRecord::Base
  attr_accessible :text, :weight, :news, :reason

  attr_accessor :user_response_id

  has_many :choices, :dependent => :destroy

  validates :text, :presence => true

  validates :user_response_id, :presence => true

  belongs_to :correct_answer, :foreign_key => 'correct_choice_id', :class_name => 'Choice'

  scope :questions_with_correct_answers, lambda { |question_ids| includes(:correct_answer).find(question_ids)}

  scope :random_questions, :order => 'random()', :select => 'id', :limit => LearningTool::QUIZ_LIMIT

  delegate :text, :to => :correct_answer, :allow_nil => true, :prefix => true

end
