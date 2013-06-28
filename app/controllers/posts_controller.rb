class PostsController < ApplicationController

  def index
    @title = "Blog"
    @posts = Post.published.page(params[:page]).per(10)
    @description = "Straight from my brain, through my fingertips, into the web. Articles about my startup life, programming, music and anything else."
  end

  def show
    @current_post = Post.friendly.find(params[:id])
    if params[:year] && !(params[:year] == @current_post.published_at.year.to_s)
      head :not_found
    end
    if params[:month] && !(params[:month] == @current_post.published_at.strftime("%m").to_s)
      head :not_found
    end
    if params[:day] && !(params[:day] == @current_post.published_at.strftime("%d").to_s)
      head :not_found
    end
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
