class Seat < ApplicationRecord
  belongs_to :shop
  has_many :quicks, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  validates :time, presence: true
  validates :count, presence: true
  
  validate :check_seat_count

  scope :ok, -> { where("time >= ?", Time.now) }
  scope :fill, -> { where("fill = ?", false)}

  def check_seat_count
      if shop && shop.seats.count > 20
        errors.add(:shop, "に予約の登録は20件までです。削除して下さい。")
      end
  end

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
