class Photo < ApplicationRecord
  belongs_to :user
  attachment :photo
end
