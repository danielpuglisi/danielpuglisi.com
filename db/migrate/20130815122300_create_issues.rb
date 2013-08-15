class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.integer :number
      t.date :published_at

      t.timestamps
    end
  end
end
