class Category < ApplicationRecord
  has_ancestry
  has_many :category_managements
  has_many :items

  with_options presence: true do
    validates :name
  end

  def self.category_parent_array_create
    category_parent_array = ['---']
    Category.where(ancestry: nil).each do |parent|
      category_parent_array << [parent.name, parent.id]
    end
    return category_parent_array
  end
end
