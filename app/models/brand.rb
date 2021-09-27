class Brand < ApplicationRecord
  has_many :items

  with_options presence: true do
    validates :name, length: { minimum: 1, maximum: 30 }
  end
end
