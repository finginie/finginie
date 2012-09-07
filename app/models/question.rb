class Question < ActiveRecord::Base
  attr_accessible :text, :weight, :news, :reason

  has_many :choices, :dependent => :destroy

  validates :text, :presence => true

  scope :_with_choices, lambda { |question_ids| includes(:choices).find(question_ids) }

  scope :random_questions, :order => 'random()', :select => 'id', :limit => Response::QUIZ_LIMIT

  delegate :text, :to => :correct_answer, :allow_nil => true, :prefix => true

end


