# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostsController < ApplicationController

  before_action :ensure_user_is_author_or_moderator, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    render :new
  end

  def edit
    @post ||= Post.find_by(id: params[:id])
    render :edit
  end

  def show
    @post = Post.find_by(id: params[:id])
    render :show
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notifications] = ["New post, #{@post.title} created"]
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def update
    @post ||= Post.find_by(id: params[:id])
    if @post.update(post_params)
      flash[:notifications] = ["Changes to #{@post.title} have been saved"]
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post ||= Post.find_by(id: params[:id])
    @post.destroy if @post
    redirect_to subs_url
  end

    protected

    def post_params
      params.require(:post).permit(:title, :url, :content, sub_ids: [])
        .merge(author_id: current_user.id)
    end

    def ensure_user_is_author_or_moderator
      @post = Post.find_by(id: params[:id])
      unless (@post.moderators + [@post.author]).include? current_user
        flash[:Unauthorized] = ["Only moderators or a post's author may edit or delete posts"]
        redirect_to post_url(@post)
      end
    end
end
