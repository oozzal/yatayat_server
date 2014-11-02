class User < ActiveRecord::Base
  attr_accessible :username, :phone_number, :sim_serial_number, :email, :first_name, :last_name, :address

  has_many :posts

  validates :sim_serial_number, presence: true, uniqueness: true

  has_reputation :karma, source: :user

  def like(post)
    post.add_evaluation(:likes, 1, self)
    post.author.add_evaluation(:karma, 1, self)
  rescue
    false
  end

  def dislike(post)
    post.add_evaluation(:dislikes, 1, self)
    post.author.add_evaluation(:karma, -1, self)
  rescue
    false
  end

end

