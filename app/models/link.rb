class Link < ActiveRecord::Base
  acts_as_taggable rescue nil
end
