class SubsController < ApplicationController

  before_action :ensure_user_is_moderator, only: [:edit, :update, :destroy]

  def new
    @sub = Sub.new
    render :new
  end

  def edit
    @sub ||= Sub.find_by(id: params[:id])
    render :edit
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    render :show
  end

  def index
    @subs = Sub.all
    render :index
  end

  def create
    @sub = Sub.new(sub_params)
    if @sub.save
      flash[:notifications] = ["New sub, #{@sub.title} created"]
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def update
    @sub ||= Sub.find_by(id: params[:id])
    if @sub.update(sub_params)
      flash[:notifications] = ["Changes to #{@sub.title} have been saved"]
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sub ||= Sub.find_by(id: params[:id])
    @sub.destroy if @sub
    redirect_to subs_url
  end

    protected

    def sub_params
      params.require(:sub).permit(:title, :description)
        .merge(moderator_id: current_user.id)
    end

    def ensure_user_is_moderator
      @sub = Sub.find_by(id: params[:id])
      unless @sub.moderator == current_user
        flash[:Unauthorized] = ["Only moderators may edit or delete subs"]
        redirect_to sub_url(@sub)
      end
    end
end
