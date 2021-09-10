class Comment < ApplicationRecord
  belongs_to :sell_item
  belongs_to :user
  has_many :notifications
end
