class Admin::IssuesController < AdminController

  before_action :set_issue, only: [:show, :edit, :update, :destroy]

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

  def destroy
    @issue.destroy
    redirect_to admin_issues_path, notice: "Issue was successfully destroyed."
  end

  private
    def set_issue
      @issue = Issue.find(params[:id])
    end

    def issue_params
      params[:issue].permit(
        :number, :published_at, :published, :body,
        links_attributes: [:id, :_destroy, :name, :url, :tag_list, :description]
      )
    end
end
