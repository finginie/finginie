class SocialNetworkController < ApplicationController
  def facebook_callback
    if published_on_fb_wall?
      post = { :post_id => params[:post_id] }
      CompletedStep.create(:step_id => params[:step], :user_id => current_user.id, :data => post )
    end

    redirect_to params[:return_to]
  end

  private
  def published_on_fb_wall?
    params[:post_id].present?
  end
end