class Event < ActiveRecord::Base
  attr_accessible :action, :data

  serialize :data, ActiveRecord::Coders::Hstore

  belongs_to :user
  belongs_to :target, :polymorphic => true

  after_create :cache_subscribers
private
  def cache_subscribers
    Resque.enqueue EventCacher, id
  end
end
