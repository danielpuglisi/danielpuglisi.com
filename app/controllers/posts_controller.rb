class PostsController < ApplicationController

  def index
    @title = "Blog"
    @posts = Post.published.page(params[:page]).per(10)
    @description = "Straight from my brain, through my fingertips, into the web. Articles about my startup life, programming, music and anything else."
  end

  def show
    @current_post = Post.friendly.find(params[:id])
    @title = @current_post.title
    @description = @current_post.content
    impressionist @current_post, nil, unique: [:impressionable_type, :impressionable_id, :ip_address]
  end

  def archive
    @title = "Archive"
    @posts = Post.published
    @posts_months = @posts.group_by { |t| t.published_at.beginning_of_month }
  end
end
