class DropOldTags < ActiveRecord::Migration
  def up
    drop_table :old_tags
    drop_table :posts_tags
  end

  def down

    create_table "old_tags" do |t|
      t.string   "title"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "slug"
    end

    create_table "posts_tags", id: false do |t|
      t.integer "post_id"
      t.integer "tag_id"
    end
  end
end
