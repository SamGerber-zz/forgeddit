class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :ensure_user_is_logged_in

  helper_method :current_user, :logged_in?, :logged_out?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def logged_out?
    !logged_in?
  end

  def log_in_user!(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
  end

  def log_out!
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
  end

  def ensure_user_is_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def ensure_user_is_not_logged_in
    redirect_to user_url(current_user) unless logged_out?
  end

    protected

    def user_params
      params.require(:user).permit(:username, :password)
    end
end
