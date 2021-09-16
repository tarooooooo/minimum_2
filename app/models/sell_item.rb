class SellItem < ApplicationRecord
  attachment :sell_item_image
  belongs_to :item
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  
  has_many :comments, dependent: :destroy
  
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User"
  
  validates :rate, presence: true
  validates :rate, numericality: {
    # only_integer: true,
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0,
  }

  
  enum payment_method: {
    credit_card: 0,
    bank_transfer: 1
  }
  
  enum order_status: {
    on_sell:   0,
    payment_waiting: 1,
    wait_shipping: 2,
    shipped:   3,
    close_of_trading: 4
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
  
  def self.search(keyword)
    where(["name like? OR brand_id like?", "%#{keyword}%", "%#{keyword}%"])
  end

  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and sell_item_id = ? and action = ? ", current_user.id, seller_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        sell_item_id: id,
        visited_id: seller_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
end
