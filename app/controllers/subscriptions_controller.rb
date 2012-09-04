class SubscriptionsController < InheritedResources::Base
  load_and_authorize_resource
  actions :index, :create, :destroy

protected
  def begin_of_association_chain
    @current_user
  end
end
