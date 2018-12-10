class Seat < ApplicationRecord
  belongs_to :shop
  has_many :quicks
  has_many :likes, dependent: :destroy
	has_many :like_users, through: :likes, source: :user


  scope :ok, -> { where("time >= ?", Time.now) }
  scope :fill, -> { where("fill = ?", false)}

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
