module UserProfileHelper
  def single_signon_change_passwords_path(origin)
    session[:user_return_to] = origin
    redirect_uri = "/oauth/authorize?client_id=#{ENV['FINGINIE_KEY']}&response_type=code&redirect_uri=#{host}/auth/single_signon/callback"
    redirect_uri=CGI::escape(redirect_uri)
    "#{ENV['AUTH_SITE_URL']}/change_password?response_type=code&client_id=#{ENV['FINGINIE_KEY']}&redirect_uri=#{redirect_uri}"
  end
end
