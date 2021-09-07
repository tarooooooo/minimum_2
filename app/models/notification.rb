class Notification < ApplicationRecord
  belongs_to :sell_item
  belongs_to :comment
end
