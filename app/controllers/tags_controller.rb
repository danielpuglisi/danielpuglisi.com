class TagsController < ApplicationController

  def show
    @tag = Tag.find_by_slug(params[:id])
    @posts = @tag.posts.published.page(params[:page]).per(10)
  end
end
