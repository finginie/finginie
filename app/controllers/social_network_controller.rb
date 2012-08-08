class SocialNetworkController < ApplicationController
  def facebook_callback
    if published_on_fb_wall?
      step_klass = params[:step].constantize
      step_klass.new(current_user).save(:post_id => params[:post_id])
    end

    redirect_to params[:return_to]
  end

  private
  def published_on_fb_wall?
    params[:post_id].present?
  end
end