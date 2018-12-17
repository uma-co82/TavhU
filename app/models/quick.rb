class Quick < ApplicationRecord
  belongs_to :seat

  validates :user_id, :uniqueness => {:scope => :friend_id}
  validates :friend_id, presence: true

  validate :check_number_of_quick
  validate :check_count_of_quick



  def check_number_of_quick
    if user_id && Quick.where(user_id: user_id).count > 4
      errors.add(:quick, "予約が掲載数を超えています。5個までです。")
    end
  end


  def check_count_of_quick
    if friend_id && Quick.where(friend_id: friend_id).count > 4
      errors.add(:quick, "相手がこれ以上リクエストを受け取れません。")
    end
  end


end
