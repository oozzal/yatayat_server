class User < ActiveRecord::Base
  attr_accessible :username, :phone_number, :sim_serial_number, :email, :first_name, :last_name, :address, :role, :cached_votes_total, :cached_votes_up, :cached_votes_down, :cached_votes_score, :cached_weighted_total, :cached_weighted_score, :cached_weighted_average

  has_many :reports

  validates :sim_serial_number, presence: true, uniqueness: true, allow_nil: true
  validates :email, uniqueness: true, allow_nil: true, allow_blank: true

  acts_as_votable
  acts_as_voter

  def like(report)
    self.likes report
    self.likes report.user
  end

  def dislike(report)
    self.dislikes report
    self.dislikes report.user
  end

end

