class Category < ApplicationRecord
  has_ancestry
  has_one :category_management
  has_many :items
  has_many :users, through: :items
end
