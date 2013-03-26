class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :tags

  # Scopes
  scope :published, where(published: true).order("published_at DESC")

  # Pagination
  paginates_per 10
end
