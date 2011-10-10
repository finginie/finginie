class Quiz < ActiveRecord::Base
  has_many :questions, :dependent => :destroy, :order => :id
  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:text].blank? }, :allow_destroy => true
end
