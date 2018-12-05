class Shop < ApplicationRecord
	attachment :shop_image
	has_many :favorites, dependent: :destroy
	has_many :favorite_users, through: :favorites, source: :user
	has_many :reservations
	has_many :seats
	belongs_to :genre
	belongs_to :station
	belongs_to :author
	validates :shop_info, length: { in: 20..76}
	validates :shop_name, presence: true
	validates :shop_info, presence: true

	def favorite_by?(user)
		favorites.where(user_id: user.id).exists?
	end
end
