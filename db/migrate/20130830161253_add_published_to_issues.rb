class AddPublishedToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :published, :boolean, default: false
  end
end
