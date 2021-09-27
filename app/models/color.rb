class Color < ApplicationRecord
  has_many :items

  with_options presence: true do
    validates :name
    validates :color_code
  end
end
