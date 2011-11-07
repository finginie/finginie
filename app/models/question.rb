class Question < ActiveRecord::Base
  attr_accessible :text, :weight, :choices_attributes
  belongs_to :quiz
  has_many :choices, :dependent => :destroy

  validates :text, :presence => true

  accepts_nested_attributes_for :choices, :reject_if => lambda { |a| a[:text].blank? }, :allow_destroy => true
end
