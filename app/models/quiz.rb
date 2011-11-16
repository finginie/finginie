class Quiz < ActiveRecord::Base
  RESULT_TYPES = ["mean","mode"]

  attr_accessible :name, :weight, :result_type, :buckets, :questions_attributes
  has_many :questions, :dependent => :destroy, :order => :id

  validates :name, :presence => true
  validates :slug, :uniqueness => true
  validates :weight, :numericality => true
  validates :result_type, :presence => true,
                          :inclusion => RESULT_TYPES

  before_validation :generate_slug
  before_validation :set_weight

  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:text].blank? }, :allow_destroy => true

private
  def generate_slug
    self.slug ||= name.try(:parameterize)
  end

  def set_weight
    self.weight ||= 1
  end

end
