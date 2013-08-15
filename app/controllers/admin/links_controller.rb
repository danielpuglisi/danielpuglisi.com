class Admin::LinksController < AdminController

  before_action :set_link, only: [:show, :edit, :update, :destroy]

  def index
    @links = Link.scoped

    if params[:issue]
      @links = links.where(issue: params[:issue])
    end
  end

  def new
    @link = Link.new
  end

  def edit
  end

  def create
    @link = Link.new(link_params)

    if @link.save
      redirect_to admin_links_path, notice: "Link was successfully created."
    else
      render action: 'new'
    end
  end

  def update
    if @link.update(link_params)
      redirect_to admin_links_path, notice: "Link was successfully updated."
    else
      render action: 'edit'
    end
  end

  def destroy
    @link.destroy
    redirect_to admin_links_path, notice: "Link was successfully destroyed."
  end

  def sort
    @link = Link.find(params[:id])

    @link.attributes = params[:link].permit(:id, :issue_order_position)
    @link.save

    # this action will be called via ajax
    render nothing: true
  end

  private
    def set_link
      @link = Link.find(params[:id])
    end

    def link_params
      params[:link].permit(:name, :url, :tag_list, :description, :issue_id)
    end
end
