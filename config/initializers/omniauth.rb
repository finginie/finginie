Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if Rails.env.development?
  provider :finginie, ENV['FINGINIE_KEY'], ENV['FINGINIE_SECRET']
  provider :signout
end
