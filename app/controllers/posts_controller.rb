class PostsController < ApplicationController
  def index
    @posts = Post.published.page params[:page]
  end

  def show
  end
end
