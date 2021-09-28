class Card < ApplicationRecord
  belongs_to :user
  
  with_options presence: true do
    validates :card_id
    validates :customer_id
  end
end
