FactoryBot.define do
  factory :item do
    user_id {1}
    color_id { 12345678909 }
    brand_id {1}
    category_id {1}
    price {100}
    item_image_id {1}
    discard_date {}
    item_status {1}
    purchase_date {'2020/10/01'}
    size {1}
    name {"name"}
    wear_count {1}
  end
end