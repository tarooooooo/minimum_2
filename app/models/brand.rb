class Brand < ApplicationRecord
  has_many :items

  with_options presence: true do
    validates :name, length: { minimum: 1, maximum: 30 }, uniqueness: true
  end

  def self.genres_create(items)
    genres = []
    brands = items.joins(:brand).group('brands.name').count
    brands = brands.sort_by{|key,val| -val}.to_h
    brand_names = brands.keys.first(10)
    brand_names.each do |name|
      genres << Brand.find_by(name: name)
    end
  end

end
