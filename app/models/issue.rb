class Issue < ActiveRecord::Base
  validates :number, uniqueness: true

  has_many :links
  accepts_nested_attributes_for :links, allow_destroy: true
end
