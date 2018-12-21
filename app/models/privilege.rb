class Privilege < ApplicationRecord
  belongs_to :shop
  validates :content, presence: true
  validates :content, length: { maximum: 30 }

  validate :check_number_of_shop

  def check_number_of_shop
    if shop && shop.privileges.count > 4
      errors.add(:privilege, "が掲載数を超えています。5個までです。")
     end
  end
end
