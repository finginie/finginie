class EventUpdatesController < InheritedResources::Base
  actions :index

  def begin_of_association_chain
    current_user
  end
end
