class Event < ActiveRecord::Base
  serialize :data => ActiveRecord::Coders::Hstore

  belongs_to :user
  belongs_to :target, :polymorphic => true
  attr_accessible :action, :data

  after_create :cache_subscribers
private
  def cache_subscribers
    Resque.enqueue EventCacher, id
  end
end
