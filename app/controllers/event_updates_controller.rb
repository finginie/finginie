class EventUpdatesController < InheritedResources::Base
  actions :index

protected
  def begin_of_association_chain
    current_user
  end

  def collection
    EventUpdateDecorator.decorate end_of_association_chain
  end

end
