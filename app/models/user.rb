class User < ApplicationRecord
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