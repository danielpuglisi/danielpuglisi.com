class OldTag < ActiveRecord::Base
  self.table_name = "old_tags"
  extend FriendlyId
  friendly_id :title, use: :slugged
end
