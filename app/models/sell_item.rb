class SellItem < ApplicationRecord
  attachment :sell_item_image
  belongs_to :item
  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  has_many :notifications, dependent: :destroy
  has_many :comments, dependent: :destroy

  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: true

  # Item.first.id == item_id

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
    temp = Notification.where(["visitor_id = ? and visited_id = ? and sell_item_id = ? and action = ? ",
                                  current_user.id, seller_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        sell_item_id: id,
        visited_id: seller_id,
        action: 'like'
      )

      if notification.visitor_id == notification.visited_id
         notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    #同じ投稿にコメントしているユーザーに通知を送る。（current_userと投稿ユーザーのぞく）
    temp_ids = Comment.where(sell_item_id: id).where.not("user_id=? or user_id=?", current_user.id,seller_id).select(:user_id).distinct
    #取得したユーザー達へ通知を作成。（user_idのみ繰り返し取得）
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    #投稿者へ通知を作成
    save_notification_comment!(current_user, comment_id, seller_id)
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
      notification = current_user.active_notifications.new(
        sell_item_id: id,
        comment_id: comment_id,
        visited_id: visited_id,
        action: 'comment'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
  end

   def create_notification_buy!(current_user)
      notification = current_user.active_notifications.new(
        sell_item_id: id,
        visited_id: seller_id,
        action: 'buy'
      )
      notification.save if notification.valid?
  end
  
  # 評価の平均
   def avg_rate
    unless self.reviews.empty?
      reviews.average(:rate).round(1).to_f
    else
      0.0
    end
  end

  def review_score_percentage
    unless self.reviews.empty?
      reviews.average(:rate).round(1).to_f*100/5
    else
      0.0
    end
  end
end
