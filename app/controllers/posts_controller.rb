class PostsController < ApplicationController

  def index
    @title = "Blog"
    @posts = Post.published.page(params[:page]).per(10)
    @description = "Straight from my brain, through my fingertips, into the web. Articles about my startup life, programming, music and anything else."
  end

  def show
    @current_post = Post.find_by_slug(params[:id])
    @title = @current_post.title
    @description = @current_post.content
  end
end
