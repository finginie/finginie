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
  helper_method :auto_page_class_names
  helper_method :auto_page_head_content

private
  def auto_page_class_names
    [params[:controller], params[:action], params[:id]].compact.map{ |n| n.split('/') }.flatten
  end

  def auto_page_head_content(translation)
    head_content = 'head_content.'
    controller_params = params[:controller].gsub('/','.') + '.'
    action_params = params[:action] + '.'
    id_params  = params[:id] ? (params[:id].gsub('/', '.') + '.') : ''
    translation = translation
    I18n.t (head_content + controller_params + action_params +id_params + translation).to_sym, :default => [(head_content + controller_params + action_params + translation).to_sym,
                                                                                                            (head_content + controller_params +translation ).to_sym,
                                                                                                            (head_content + translation).to_sym, translation ]

  end

  def current_user
    @current_user ||= User.find session[:user_id] if session[:user_id]
  end
end
