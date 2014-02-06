class Admin::IssuesController < AdminController

  before_action :set_issue, except: [:index, :new, :create]

  def index
    @issues = Issue.order("published_at DESC")
  end

  def new
    @issue = Issue.new
  end

  def edit
  end

  def create
    @issue = Issue.new(issue_params)

    if @issue.save
      redirect_to edit_admin_issue_path(@issue), notice: "Issue was successfully created."
    else
      render action: 'new'
    end
  end

  def update
    if @issue.update(issue_params)
      redirect_to edit_admin_issue_path(@issue), notice: "Issue was successfully updated."
    else
      render action: 'edit'
    end
  end

  def import_from_delicious
    posts = DELICIOUS.posts_all(tag: "!fiw-#{@issue.number}")
    posts.each do |post|
      link = Link.find_or_initialize_by(delicious_id: post.uid)
      if link.new_record?
        link.issue       = @issue
        link.name        = post.title
        link.url         = post.url.to_s
        link.description = post.notes
        link.tag_list    = post.tags.delete_if { |t| t == "!fiw-#{@issue.number}" }.join(", ")
        link.save
      end
    end
    redirect_to edit_admin_issue_path(@issue), notice: "Delicious links successfully imported."
  end

  def destroy
    @issue.destroy
    redirect_to admin_issues_path, notice: "Issue was successfully destroyed."
  end

  private
    def set_issue
      @issue = Issue.find(params[:id] || params[:issue_id])
    end

    def issue_params
      params[:issue].permit(
        :number, :published_at, :published, :body,
        links_attributes: [:id, :_destroy, :name, :url, :tag_list, :description]
      )
    end
end
