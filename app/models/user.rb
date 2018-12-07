class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image
  has_many :favorites, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :quicks, dependent: :destroy
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships
  has_many :notifications, dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key:
  "follower_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :following, through: :active_relationships
  has_many :reservations

  #chat
  has_many :from_messages, class_name: "Message",
            foreign_key: "from_id", dependent: :destroy
  has_many :to_messages, class_name: "Message",
            foreign_key: "to_id", dependent: :destroy
  has_many :sent_messages, through: :from_messages, source: :from
  has_many :received_messages, through: :to_messages, source: :to

  def following?(other_user)
    following_relationships.find_by(following_id: other_user.id)
  end

  def follow!(other_user)
    following_relationships.create!(following_id: other_user.id)
  end

  def unfollow!(other_user)
    following_relationships.find_by(following_id: other_user.id).destroy
  end

  def matchers
    User.where(id: passive_relationships.select(:follower_id)).where(id: active_relationships.select(:following_id))
  end

  # send dm
  def send_message(other_user, room_id, content)
    from_messages.create!(to_id: other_user.id, room_id: room_id, content: content)
  end
end
