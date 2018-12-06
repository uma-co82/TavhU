class Seat < ApplicationRecord
  belongs_to :shop
  has_many :quicks
  has_many :likes, dependent: :destroy
	has_many :like_users, through: :likes, source: :user

  def liked_by?(user) #いいねしているかどうか
    likes.where(user_id: user.id).exists?
  end
end
