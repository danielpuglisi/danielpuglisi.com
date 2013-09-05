class Link < ActiveRecord::Base
  acts_as_taggable rescue nil

  include RankedModel

  validates :name, :url, presence: true
  validates :url, uniqueness: true

  belongs_to :issue
  ranks :issue_order, with_same: :issue_id

  default_scope { rank(:issue_order) }
  scope :published, -> { includes(:issue).where("issues.published = ? OR links.issue_id IS ?", true, nil).references(:issue) }

  def url=(url)
    write_attribute(:url, url.match(/(.*[^\/])\/*$/)[1])
  end
end
