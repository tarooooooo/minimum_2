class Category < ApplicationRecord
  has_ancestry
  has_many :category_managements
  has_many :items
  has_many :users, through: :items
end
