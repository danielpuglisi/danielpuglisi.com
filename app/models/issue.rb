class Issue < ActiveRecord::Base
  validates :number, uniqueness: true

  has_many :links
end
