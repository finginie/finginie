ENV['FACEBOOK_SHARE_DIALOG_URL'] = 'https://www.facebook.com/dialog/feed?'

if Rails.env.development? || Rails.env.test?
  ENV['FACEBOOK_KEY'] = '356501381094220'
end
