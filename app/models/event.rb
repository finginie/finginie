class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :target, :polymorphic => true
  attr_accessible :action, :data

  after_create :cache_subscribers
private
  def cache_subscribers
    Resque.enqueue EventCacher, id
  end
end
