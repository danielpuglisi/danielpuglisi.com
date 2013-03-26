class Post < ActiveRecord::Base
  has_many :tags

  attr_accessible :title, :content,
    :published_at, :published,
    :external_link, :type,
    :slug
end
