class AddIssueOrderToLinks < ActiveRecord::Migration
  def change
    add_column :links, :issue_order, :integer
  end
end
