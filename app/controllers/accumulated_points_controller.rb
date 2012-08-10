class AccumulatedPointsController < ApplicationController
  before_filter :check_for_user_access, :only => [:index]
  def index

  end

  def check_for_user_access
    redirect_to signin_path(:origin => accumulated_points_path), :notice => "Please Sign In or Register to view your points" unless current_user
  end
end