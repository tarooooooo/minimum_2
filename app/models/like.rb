class Like < ApplicationRecord
  belongs_to :sell_item
  belongs_to :user
  
  validates_uniqueness_of :sell_item_id, scope: :user_id
end
