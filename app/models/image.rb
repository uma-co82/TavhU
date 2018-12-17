class Image < ApplicationRecord
  belongs_to :shop
  attachment :image
end
