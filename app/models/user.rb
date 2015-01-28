class User < ActiveRecord::Base
  attr_accessible :username, :phone_number, :sim_serial_number, :email, :first_name, :last_name, :address, :role, :cached_votes_total, :cached_votes_up, :cached_votes_down, :cached_votes_score, :cached_weighted_total, :cached_weighted_score, :cached_weighted_average

  has_many :reports

  validates :sim_serial_number, presence: true, uniqueness: true, allow_nil: true
  validates :email, uniqueness: true, allow_nil: true, allow_blank: true

  acts_as_votable
  acts_as_voter

  after_update :notify_role_changed, :if => :role_changed?

  def like(report)
    self.likes report
    self.likes report.user
  end

  def dislike(report)
    self.dislikes report
    self.dislikes report.user
  end

  private

  def notify_role_changed
    Emailer.send_mail(email, "Yatayat Role Changed", "Dear #{username}, Your role has been changed from #{role_was} to #{role}.").deliver if username.present? && email.present?
  end

end

