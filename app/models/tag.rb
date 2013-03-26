class Tag < ActiveRecord::Base
  belongs_to :post

  attr_accessible :post_id, :title
end
