class EventUpdateDecorator < ApplicationDecorator
  decorates :event_update

  def event
    EventDecorator.decorate model.event
  end
  delegate :icon, :content, :title, :to => :event

  def actor
    ProfileDecorator.decorate(event.user)
  end
  delegate :avatar, :to => :actor
end
