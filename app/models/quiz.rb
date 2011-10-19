class Quiz < ActiveRecord::Base
  has_many :questions, :dependent => :destroy, :order => :id

  before_validation :generate_slug

  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:text].blank? }, :allow_destroy => true

private
  def generate_slug
    self.slug ||= name.parameterize
  end
end
