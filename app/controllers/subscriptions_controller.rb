class SubscriptionsController < InheritedResources::Base
  actions :index, :create, :destroy

protected
  def begin_of_association_chain
    @current_user
  end
end
