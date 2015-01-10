class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :sub_categories
  has_many :posts, through: :sub_categories
end

