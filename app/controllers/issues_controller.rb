class IssuesController < ApplicationController

  before_filter :authenticate_mc_subscription

  def index
    @issues = Issue.published.order('published_at DESC')
    @issues_months = @issues.group_by { |t| t.published_at.beginning_of_month }
  end

  def show
    if params[:bacon] == "strips"
      @issue = Issue.find_by(number: params[:number])
    else
      @issue = Issue.published.find_by(number: params[:number])
    end
  end
end
