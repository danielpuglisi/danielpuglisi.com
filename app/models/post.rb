class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :use_title_when_slug_is_empty, use: :slugged

  has_and_belongs_to_many :tags

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
