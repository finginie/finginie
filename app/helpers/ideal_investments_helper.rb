module IdealInvestmentsHelper
  def twitter_share_description
    I18n.t('twitter_share.description', :user_slug => current_user.slug_name, :share_url => url_with_complete_path(public_financial_profile_path(current_user)))
  end

  def twitter_post_url
    "#{ENV['AUTHENTICATION_URL']}/twitter_post?redirect_uri=#{current_page_url}"
  end
end
