class Admin::LinksController < AdminController

  def index
    @links = Link.all
  end
end
