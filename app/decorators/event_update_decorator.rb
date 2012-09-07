class EventUpdateDecorator < ApplicationDecorator
  decorates :event_update

  def event
    EventDecorator.decorate model.event
  end

  delegate :icon, :content, :to => :event
end
