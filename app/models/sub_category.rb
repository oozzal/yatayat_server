class SubCategory < ActiveRecord::Base
  attr_accessible :name

  belongs_to :category
  has_many :posts
end
