class LinksController < ApplicationController

  before_filter :authenticate_mc_subscription

  def index
    q = params[:q]
    @links = Link.published.search(name_or_url_or_tags_name_cont: q).result(distinct: true)
    @links = @links.page(params[:page]).per(30)
  end
end
