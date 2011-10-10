class Question < ActiveRecord::Base
  belongs_to :quiz
  has_many :choices, :dependent => :destroy
#has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :choices, :reject_if => lambda { |a| a[:text].blank? }, :allow_destroy => true
end
