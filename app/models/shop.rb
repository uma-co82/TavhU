class Shop < ApplicationRecord
	attachment :shop_image

	has_many :favorites, dependent: :destroy
	has_many :favorite_users, through: :favorites, source: :user
	has_many :seats, dependent: :destroy
	has_many :privileges, dependent: :destroy
	has_many :images, dependent: :destroy
	has_many :reviews, dependent: :destroy
	
	accepts_attachments_for :images, attachment: :image

	belongs_to :genre
	belongs_to :station
	belongs_to :author

	validates :shop_info, length: { maximum: 600 }
	validates :shop_name, presence: true
	validates :shop_info, presence: true
	validates :genre_id, presence: true
	validates :station_id, presence: true
	validates :address_city, presence: true
	validates :postcode, presence: true
	validates :prefecture_code, presence: true
	validates :address_street, presence: true 
	
	validate :check_shop_count

	geocoded_by :address
	after_validation :geocode, if: :address_changed?

class << self
	def within_box(distance, latitude, longitude)
		distance = distance
		center_point = [latitude, longitude]
		box = Geocoder::Calculations.bounding_box(center_point, distance)
		self.within_bounding_box(box)
	end
end



	def check_shop_count
		if author && author.shops.count > 5
			errors.add(:shop, "登録は5件までです。")
		end
	end


	include JpPrefecture
  jp_prefecture :prefecture_code
	
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

	def favorite_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def self.search(search)
		if search
			joins(:station).includes(:station).where("stations.station_name LIKE ?", "%#{search}%")
		else
			all
		end
	end

end
