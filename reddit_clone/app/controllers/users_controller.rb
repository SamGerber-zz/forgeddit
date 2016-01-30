# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class UsersController < ApplicationController

  skip_before_action :ensure_user_is_logged_in, only: [:new, :create]
  before_action :ensure_user_is_not_logged_in, only: [:new, :create]

  def create
    @user = User.new(user_params)
    if @user.save
      log_in_user!(@user)
      flash[:notifications] = ["Welcome to Reddit Clone, #{@user.username}"]
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    render :show
  end

  def index
    @users = User.all
    render :index
  end

  def new
    @user = User.new
    render :new
  end

  def edit
    @user = User.find_by(id: params[:id])
    render :edit
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      flash[:notifications] = ["Changes saved!"]
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      @user = User.new(user_params)
      render :edit
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy if @user
    redirect_to users_url
  end
end
