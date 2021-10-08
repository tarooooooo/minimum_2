class Color < ApplicationRecord
  has_many :items

  with_options presence: true do
    validates :name, uniqueness: true
    validates :color_code, uniqueness: true
  end
  
  
  def self.genres_create(items)
    genres = []
    colors = items.joins(:color).group('colors.name').count
    colors = colors.sort_by{|key,val| -val}.to_h
    color_names = colors.keys.first(10)
    color_names.each do |name|
      genres << Color.find_by(name: name)
    end
  end
end
