class Post < ActiveRecord::Base

  extend FriendlyId
  friendly_id :use_title_when_slug_is_empty, use: :slugged

  is_impressionable counter_cache: {column_name: :impressions_count, unique: true}

  acts_as_taggable

  # Scopes
  default_scope { order("published_at DESC").order("published") }

  class << self
    def published
      where(published: true)
    end
  end

  # Validations
  validates :title, :content, :style, :published_at, presence: true
  validates :slug, presence: true, on: :update

  def use_title_when_slug_is_empty
    if slug.nil? || slug.empty?
      title
    else
      slug
    end
  end
end
