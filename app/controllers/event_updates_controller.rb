class EventUpdatesController < InheritedResources::Base
  actions :index

protected
  def begin_of_association_chain
    current_user
  end

  def resource
    EventUpdateDecorator.decorate end_of_association_chain
  end

end
