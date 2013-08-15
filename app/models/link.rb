class Link < ActiveRecord::Base
  acts_as_taggable rescue nil

  include RankedModel
  ranks :issue_order, with_same: :issue_id

  validates :url, uniqueness: true

  belongs_to :issue

  def url=(url)
    write_attribute(:url, url.match(/(.*[^\/])\/*$/)[1])
  end
end
