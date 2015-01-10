class User < ActiveRecord::Base
  attr_accessible :username, :phone_number, :sim_serial_number, :email, :first_name, :last_name, :address, :cached_votes_total, :cached_votes_up, :cached_votes_down, :cached_votes_score, :cached_weighted_total, :cached_weighted_score, :cached_weighted_average

  has_many :posts

  validates :sim_serial_number, presence: true, uniqueness: true

  acts_as_votable
  acts_as_voter

  def like(post)
    self.likes post
    self.likes post.user
  end

  def dislike(post)
    self.dislikes post
    self.dislikes post.user
  end

end

