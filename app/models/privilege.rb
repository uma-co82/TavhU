class Privilege < ApplicationRecord
  belongs_to :shop

  validate :check_number_of_shop

  def check_number_of_shop
    if shop && shop.privileges.count > 5
      errors.add(:shop, "掲載数を超えています。")
     end
  end
end
