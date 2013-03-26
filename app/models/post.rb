class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :tags

  # Scopes
  scope :published, where(published: true).order("published_at DESC")
end
