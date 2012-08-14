module IdealInvestmentsHelper
  def twitter_share_description
    I18n.t('twitter_share.description', :user_slug => current_user.slug_name, :share_url => url_with_complete_path(public_financial_profile_path(current_user)))
  end
end
