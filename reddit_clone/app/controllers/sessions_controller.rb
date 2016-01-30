class SessionsController < ApplicationController

  skip_before_action :ensure_user_is_logged_in, only: [:new, :create]
  before_action :ensure_user_is_not_logged_in, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params)
    if @user
      log_in_user!(@user)
      flash[:notifications] = ["Welcome back, #{@user.username}!"]
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid credentials"]
      @user = User.new(user_params)
      render :new
    end
  end

  def destroy
    log_out!
    flash[:notifications] = ["Logged out!"]
    redirect_to new_session_url
  end
end
