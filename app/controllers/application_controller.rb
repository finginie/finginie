class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json

  rescue_from CanCan::AccessDenied do |exception|
    current_user ? redirect_back_with(exception) : redirect_to_login
  end

  def redirect_to_login
    session[:user_return_to] = request.fullpath
    redirect_to new_user_session_path
  end

  def redirect_back_with(exception)
    begin
      redirect_to :back, :alert => exception.message
    rescue ActionController::RedirectBackError
      redirect_to :root, :alert => exception.message
    end
  end

  def current_user
    User.first_or_create!
  end
  helper_method :current_user
end
