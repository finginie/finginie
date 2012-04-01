class Subscription < ActiveRecord::Base
  attr_accessible :subscribable, :subscribable_id, :subscribable_type

  belongs_to :user
  belongs_to :subscribable, :polymorphic => true

  validates :user_id, :presence => true
  validates :subscribable_type, :presence => true
  validates :subscribable_id, :presence => true,
                              :uniqueness => { :scope => [:user_id, :subscribable_type] }
end
