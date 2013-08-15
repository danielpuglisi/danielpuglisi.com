class Admin::IssuesController < AdminController

  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  def index
    @issues = Issue.all
  end

  def new
    @issue = Issue.new
  end

  def edit
  end

  def create
    @issue = Issue.new(issue_params)

    if @issue.save
      redirect_to admin_issues_path, notice: "Issue was successfully created."
    else
      render action: 'new'
    end
  end

  def update
    if @issue.update(issue_params)
      redirect_to admin_issues_path, notice: "Issue was successfully updated."
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
        :number, :published_at,
        links_attributes: [:name, :url, :tag_list, :description]
      )
    end
end
