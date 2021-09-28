class Color < ApplicationRecord
  has_many :items

  with_options presence: true do
    validates :name, uniqueness: true
    validates :color_code, uniqueness: true
  end
end
