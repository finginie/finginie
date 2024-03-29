class SocialNetworkController < ApplicationController
  def facebook_callback
    if published_on_fb_wall?
      step_klass = params[:step].constantize
      meta_data  = { :post_id => params[:post_id] }
      step_klass.new(current_user, meta_data).save
    end

    redirect_to params[:return_to]
  end

  def twitter_callback
    if params[:type] == 'error'
      params[:msg].gsub!('Status','Tweet')
    else
      step_klass = params[:step].constantize
      step_klass.new(current_user).save
    end
    flash[params[:type]] = params[:msg]
    redirect_to params[:return_to]
  end

  private
  def published_on_fb_wall?
    params[:post_id].present?
  end
end