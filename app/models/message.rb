class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :body, presence: true
  validates :body, length: { minimum: 1, maximum: 200 }
end
