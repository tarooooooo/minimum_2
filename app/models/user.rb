class User < ApplicationRecord
  
  validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'に全角文字を使用してください'}
  validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'に全角文字を使用してください' }
  validates :last_name_kana, format: { with: /[\p{katakana} ー－]+/, message: 'はカタカナで入力して下さい。'}
  validates :first_name_kana, format: { with: /[\p{katakana} ー－]+/, message: 'はカタカナで入力して下さい。',}
  validates :postal_code, format: { with: /\A\d{7}\z/}
  validates :address, presence: true
  validates :phone_number, format: { with: /\A\d{10,11}\z/}
  attachment :icon_image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :category_managements, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :categories, through: :items
  
  has_many :notifications, dependent: :destroy

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  has_many :sell_items, class_name: 'SellItem', foreign_key: 'seller_id', dependent: :destroy
  has_many :buy_items, class_name: 'SellItem', foreign_key: 'buyer_id', dependent: :destroy
  
  has_many :sell_items, class_name: "SellItem", foreign_key: :seller_id
  has_many :sellers, through: :sell_items, source: :buyer
  has_many :buy_items, class_name: "SellItem",foreign_key: :buyer_id
  has_many :buyers, through: :sell_items, source: :seller
  
  has_many :likes, dependent: :destroy
  has_many :liked_sell_items, through: :likes, source: :sell_item
  
  has_many :comments, dependent: :destroy
  def already_liked?(sell_item)
    self.likes.exists?(sell_item_id: sell_item.id)
  end
end