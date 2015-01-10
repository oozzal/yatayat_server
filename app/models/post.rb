class Post < ActiveRecord::Base
  attr_accessible :title, :body, :user_id, :sub_category_id, :cached_votes_total, :cached_votes_up, :cached_votes_down, :cached_votes_score, :cached_weighted_total, :cached_weighted_score, :cached_weighted_average

  belongs_to :user
  belongs_to :sub_category
  has_one :category, through: :sub_category

  acts_as_votable

end

