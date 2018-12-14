class Quick < ApplicationRecord
  belongs_to :seat

  validate :check_number_of_quick


  def check_number_of_quick
    if user_id && Quick.where(user_id: user_id).count > 5
      errors.add(:quick, "予約が掲載数を超えています。5個までです。")
    end
  end
end
