module EbolaHelper
  def tracked_facebook_share_url_for(type)
    config_params_hsh = send("#{type}_fb_hsh")
    content_tag('span', :class => 'ga-track-event', :data => {:category => 'share', :action => 'facebook'}) do
      link_to facebook_share_url(config_params_hsh) do
        image_tag 'facebook.png'
      end
    end
  end

  private
  def facebook_share_url(params_hsh)
    ENV['FACEBOOK_SHARE_DIALOG_URL'] + fb_share_query_params(params_hsh)
  end

  def public_portfolio_fb_hsh
    name = translated_name_for('public_portfolio')
    description = translated_description_for('public_portfolio')

    {
      :link => public_portfolio_url(resource),
      :name => name,
      :description => description,
      :redirect_uri => facebook_callback_url_with_step(PointTracker::SharePortfolioOnFbStep)
    }
  end

  def public_financial_profile_fb_hsh
    name = translated_name_for('public_financial_profile')
    description = translated_description_for('public_financial_profile')

    {
      :link => public_financial_profile_url(current_user),
      :name => name,
      :description => description,
      :redirect_uri => facebook_callback_url_with_step(PointTracker::ShareFinancialProfileOnFbStep)
    }
  end

  def facebook_callback_url_with_step(step)
    social_network_facebook_callback_url(:return_to => current_page_url, :step => step)
  end

  def fb_share_query_params(params_hsh)
    {
      :app_id => ENV['FACEBOOK_KEY'],
      :picture => host + '/assets/logo.png'
    }.merge(params_hsh).to_query
  end

  def translated_name_for(type)
    t("ebola_share.facebook.#{type}.name", :user_slug => current_user.slug_name)
  end

  def translated_description_for(type)
    t("ebola_share.facebook.#{type}.description")
  end
end
