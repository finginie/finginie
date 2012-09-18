class EventCacher
  @queue = :events_queue

  def self.perform(event_id)
    event = Event.find event_id

    event.user.follow_subscriptions.each do |subscription|
      EventUpdate.create do |e|
        e.user_id = subscription.user_id
        e.event_id = event_id
      end
    end
    event.target.subscriptions.each do |subscription|
      EventUpdate.create do |e|
        e.user_id = subscription.user_id
        e.event_id = event_id
      end
    end
  end
end
