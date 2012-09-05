module EbolaHelper
  STEPS = {
    :public_portfolio         => PointTracker::SharePortfolioOnFbStep,
    :public_financial_profile => PointTracker::ShareFinancialProfileOnFbStep
  }.with_indifferent_access

  def tracked_facebook_share_url_for(type)
    config_params_hash  = query_object(type).marshal_dump
    facebook_share_url = ENV['FACEBOOK_SHARE_DIALOG_URL'] + fb_share_query_params(config_params_hash)

    content_tag('span', :class => 'ga-track-event', :data => {:category => 'share', :action => 'facebook'}) do
      link_to facebook_share_url do
        image_tag 'facebook.png'
      end
    end
  end

  private
  def query_object(type)
    query_params              = OpenStruct.new
    query_params.link         = send("#{type}_share_url")
    query_params.name         = translated_name_for(type)
    query_params.description  = translated_description_for(type)
    query_params.redirect_uri = facebook_callback_url_with_step(STEPS[type])

    query_params
  end

  def public_portfolio_share_url
    public_portfolio_url(resource)
  end

  def public_financial_profile_share_url
    public_financial_profile_url(current_user)
  end

  def facebook_callback_url_with_step(step)
    social_network_facebook_callback_url(:return_to => current_page_url, :step => step)
  end

  def fb_share_query_params(params_hash)
    {
      :app_id => ENV['FACEBOOK_KEY'],
      :picture => host + '/assets/logo.png'
    }.merge(params_hash).to_query
  end

  def translated_name_for(type)
    t("ebola_share.facebook.#{type}.name", :user_slug => current_user.slug_name)
  end

  def translated_description_for(type)
    t("ebola_share.facebook.#{type}.description")
  end
end
