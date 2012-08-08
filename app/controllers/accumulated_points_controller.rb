class AccumulatedPointsController < ApplicationController
  before_filter :check_for_user_access, :only => [:index]
  def index

  end

  def check_for_user_access
    redirect_to root_path, :notice => "You don't have access to this page" unless current_user
  end
end