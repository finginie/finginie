class Quiz < ActiveRecord::Base
  attr_accessible :name, :weight
  has_many :questions, :dependent => :destroy, :order => :id

  validates :name, :presence => true

  before_validation :generate_slug

  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:text].blank? }, :allow_destroy => true

private
  def generate_slug
    self.slug ||= name.try(:parameterize)
  end
end
