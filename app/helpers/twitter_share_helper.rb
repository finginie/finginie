module TwitterShareHelper
  STEPS = {
    :public_portfolio         => PointTracker::SharePortfolioOnFbStep,
    :public_financial_profile => PointTracker::ShareFinancialProfileOnTwitterStep
  }.with_indifferent_access

  def twitter_share_description_for(type)
    share_url = send("#{type}_share_url")
    shortened_share_url = Shortly::Clients::Googl.shorten(share_url).shortUrl
    t("ebola_share.twitter.#{type}.description", :share_url => shortened_share_url)
  end

  def twitter_post_url_for(type)
    query_params = {
      :return_to    => current_page_url,
      :step         => STEPS[type],
      :callback_url => social_network_twitter_callback_url
    }.to_query

    "#{ENV['AUTH_SITE_URL']}/twitter_post?#{query_params}"
  end

  private
  def public_portfolio_share_url
    public_portfolio_url(resource)
  end

  def public_financial_profile_share_url
    public_financial_profile_url(current_user)
  end
end