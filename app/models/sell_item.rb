class SellItem < ApplicationRecord
  attachment :sell_item_image
  belongs_to :item
end
