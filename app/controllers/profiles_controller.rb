class ProfilesController < InheritedResources::Base
  defaults :resource_class => User
  actions :all, :except => [:new, :create, :destroy]

  before_filter :resource, :except => :index
  load_and_authorize_resource :user, :parent => false

  def resource
    @profile ||= params[:id] ? super : current_user
  end

  def collection
    @search   = end_of_association_chain.search(params[:search])
    @profiles = @search.page params[:page]
  end
end
