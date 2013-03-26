class AddPostIdToTags < ActiveRecord::Migration
  def change
    add_column :tags, :post_id, :integer
  end
end
