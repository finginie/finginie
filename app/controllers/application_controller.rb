class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :json

  rescue_from CanCan::AccessDenied do |exception|
    current_user ? redirect_back_with(exception) : redirect_to_login
  end

  def redirect_to_login
    session[:user_return_to] = request.fullpath
    redirect_to signin_path
  end

  def redirect_back_with(exception)
    begin
      redirect_to :back, :alert => exception.message
    rescue ActionController::RedirectBackError
      redirect_to :root, :alert => exception.message
    end
  end

  helper_method :current_user

private
  def current_user
    @current_user ||= User.find session[:user_id] if session[:user_id]
  end
end
