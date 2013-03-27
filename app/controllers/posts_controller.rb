class PostsController < ApplicationController
  def index
    @posts = Post.published.page(params[:page]).per(10)
  end

  def show
    @current_post = Post.find_by_slug(params[:id])
  end
end
