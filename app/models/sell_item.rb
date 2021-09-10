class SellItem < ApplicationRecord
  belongs_to :brand
  belongs_to :color
  has_many :notifications
  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"
end
