module IdealInvestmentsHelper
  def twitter_share_description(share_url)
    shortened_share_url = Shortly::Clients::Googl.shorten(share_url).shortUrl
    I18n.t('twitter_share.description', :share_url => shortened_share_url)
  end

  def twitter_post_url
    hsh = {
      :return_to    => current_page_url,
      :step         => PointTracker::ShareFinancialProfileOnTwitterStep,
      :callback_url => url_with_complete_path(social_network_twitter_callback_path)
    }
    "#{ENV['AUTH_SITE_URL']}/twitter_post?#{hsh.to_query}"
  end
end
