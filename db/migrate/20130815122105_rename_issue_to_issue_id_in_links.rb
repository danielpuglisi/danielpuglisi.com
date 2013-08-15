class RenameIssueToIssueIdInLinks < ActiveRecord::Migration
  def change
    rename_column :links, :issue, :issue_id
  end
end
