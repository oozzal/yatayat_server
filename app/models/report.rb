class Report < ActiveRecord::Base
  attr_accessible :message, :user_id, :location_id, :category_id, :cached_votes_total, :cached_votes_up, :cached_votes_down, :cached_votes_score, :cached_weighted_total, :cached_weighted_score, :cached_weighted_average

  belongs_to :user
  belongs_to :location
  belongs_to :category

  acts_as_votable

end

