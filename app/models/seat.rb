class Seat < ApplicationRecord
  belongs_to :shop
  has_many :quicks
end
