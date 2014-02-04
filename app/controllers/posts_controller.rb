class PostsController < ApplicationController

  before_filter :get_tags

  def index
    @title = "Blog"
    @posts = Post.published.page(params[:page]).per(10)
    @description = "Straight from my brain, through my fingertips, into the web. Articles about my startup life, programming, music and anything else."
  end

  def show
    post = Post.friendly
    if params[:bacon] == "strips"
      @current_post = post.find(params[:id])
    else
      @current_post = post.published.find(params[:id])
    end

    # TODO: Refactor
    if params[:year] && !(params[:year] == @current_post.published_at.year.to_s)
      head :not_found
    end
    if params[:month] && !(params[:month] == @current_post.published_at.strftime("%m"))
      head :not_found
    end
    if params[:day] && !(params[:day] == @current_post.published_at.strftime("%d"))
      head :not_found
    end

    @title = @current_post.title
    @description = @current_post.content
  end

  def tags
    @tag = ActsAsTaggableOn::Tag.friendly.find(params[:id])
    @posts = Post.published.tagged_with(@tag.name)
  end

  def archive
    @title = "Archive"
    @posts = Post.published
    @posts_months = @posts.group_by { |t| t.published_at.beginning_of_month }
  end

  private
    def get_tags
      @tags = Post.published.tag_counts
    end
end
