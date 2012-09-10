class Subscription < ActiveRecord::Base
  attr_accessible :subscribable, :subscribable_id, :subscribable_type

  belongs_to :user
  belongs_to :subscribable, :polymorphic => true

  scope :of_type, lambda { |type| where(:subscribable_type => type) }

  validates :user_id, :presence => true
  validates :subscribable_type, :presence => true
  validates :subscribable_id, :presence => true,
                              :uniqueness => { :scope => [:user_id, :subscribable_type] }

  after_create :create_event

private
  def create_event
    Event.create do |event|
      event.user = user
      event.target = subscribable
      event.action = 'new_subscription'
    end
  end
end
