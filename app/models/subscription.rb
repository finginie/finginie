class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :subscribable, :polymorphic => true

  validates :user_id, :presence => true
  validates :subscribable_type, :presence => true
  validates :subscribable_id, :presence => true,
                              :uniqueness => { :scope => [:user_id, :subscribable_type] }
end
