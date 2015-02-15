class User < ActiveRecord::Base
  attr_accessible :username, :phone_number, :sim_serial_number, :device_registration_id, :notify, :email, :first_name, :last_name, :address, :role, :cached_votes_total, :cached_votes_up, :cached_votes_down, :cached_votes_score, :cached_weighted_total, :cached_weighted_score, :cached_weighted_average

  has_many :reports

  validates :sim_serial_number, presence: true, uniqueness: true, allow_nil: true
  validates :email, uniqueness: true, allow_nil: true, allow_blank: true

  acts_as_votable
  acts_as_voter

  paginates_per 5

  after_update :notify_role_changed, :if => :role_changed?

  def like(report)
    self.likes report
    self.likes report.user
  end

  def dislike(report)
    self.dislikes report
    self.dislikes report.user
  end

  def self.notify_all(msg)
    reg_ids = User.where('device_registration_id is not null').where(notify: true).map(&:device_registration_id)
    Notifier.notify(msg, reg_ids) if reg_ids.present?
  end

  private

  def notify_role_changed
    if !Rails.env.development? && username.present? && email.present?
      msg = "Your role has been changed from #{role_was} to #{role}."
      Notifier.notify({title: "Role Changed", message: msg}, [device_registration_id]) if device_registration_id.present?
      Emailer.send_mail(email, "Yatayat Role Changed", "Dear #{username}, #{msg}").deliver if username.present? && email.present?
    end
  end

end

