class CategoryManagement < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :user_id, uniqueness: true
  validates :user_id, presence: true
  validates :limit, presence: true
  validates :category_id, presence: true
end
