class PostsController < ApplicationController
  def index
    @posts = Post.published
  end

  def show
  end
end
