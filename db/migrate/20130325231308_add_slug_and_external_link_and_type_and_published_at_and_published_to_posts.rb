class AddSlugAndExternalLinkAndTypeAndPublishedAtAndPublishedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :slug, :string
    add_column :posts, :external_link, :string
    add_column :posts, :type, :string
    add_column :posts, :published_at, :date
    add_column :posts, :published, :boolean
  end
end
