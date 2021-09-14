class SellItem < ApplicationRecord
  attachment :sell_item_image
  belongs_to :item
  
  enum payment_method: {
    credit_card: 0,
    bank_transfer: 1
  }
  
  enum order_status: {
    on_sell:   0,
    wait_shipping: 1,
    shipped:   2,
    wait_rating: 3
  }
  
   enum delivery_charged:{
    shipping_fee_on_shipper:    0,  #送料込み（出品者負担）
    shipping_fee_on_receiver:   1,  #着払い（購入者負担）
  },_prefix: true

  enum delivery_way:{
    kuroneko_yamato:        0, #クロネコヤマト
    yu_pack:                1, #ゆうパック
    yu_mail:                2, #ゆうメール
    letter_pack:            3, #レターパック
    normal:                 4, #普通郵便（定型、定型外）
    clickpost:              5, #クリックポスト
  },_prefix: true

  enum delivery_days:{
    days1_2:    0,  #1日~2日で発送
    days2_3:    1,  #2日~3日で発送
    days4_7:    2,  #4日~7日で発送
  },_prefix: true

end
