class Post < ActiveRecord::Base
  attr_accessible :title, :body, :user_id, :sub_category_id

  belongs_to :user
  belongs_to :sub_category
  has_one :category, through: :sub_category

  has_reputation :likes, source: :user
  has_reputation :dislikes, source: :user
end

