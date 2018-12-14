class Image < ApplicationRecord
  belongs_to :shop
  attachment :image

  validate :check_image_count

  def check_image_count
    if shop && shop.images.count < 3
      errors.add(:image, "imageは３件以上登録して下さい")
    end
  end
end
