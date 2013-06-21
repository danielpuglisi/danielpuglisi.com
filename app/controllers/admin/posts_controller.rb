class Admin::PostsController < AdminController

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to edit_admin_post_path(@post), notice: 'Post was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @post.update(post_params)
      redirect_to edit_admin_post_path(@post), notice: 'Post was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by_slug(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params[:post].permit(:title, :content, :published, :published_at, :style, :external_link, tag_ids: [])
    end
end
