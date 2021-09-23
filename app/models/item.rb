class Item < ApplicationRecord

  scope :purchase_date_thismonth, -> { where(purchase_date: Time.zone.now.all_month) } # 今月
  scope :purchase_date_1month_ago, -> { where(purchase_date: 1.month.ago.all_month) } # 先月
  scope :purchase_date_2month_ago, -> { where(purchase_date: 2.month.ago.all_month) } # 2月前
  scope :purchase_date_3month_ago, -> { where(purchase_date: 3.month.ago.all_month) } # 3月前
  scope :purchase_date_4month_ago, -> { where(purchase_date: 4.month.ago.all_month) } # 4月前
  scope :purchase_date_5month_ago, -> { where(purchase_date: 5.month.ago.all_month) } # 5月前
  scope :purchase_date_6month_ago, -> { where(purchase_date: 6.month.ago.all_month) } # 6月前
  scope :purchase_date_7month_ago, -> { where(purchase_date: 7.month.ago.all_month) } # 7月前
  scope :purchase_date_8month_ago, -> { where(purchase_date: 8.month.ago.all_month) } # 8月前
  scope :purchase_date_9month_ago, -> { where(purchase_date: 9.month.ago.all_month) } # 9月前
  scope :purchase_date_10month_ago, -> { where(purchase_date: 10.month.ago.all_month) } # 10月前
  scope :purchase_date_11month_ago, -> { where(purchase_date: 11.month.ago.all_month) } # 11月前


  attachment :item_image
  belongs_to :user
  belongs_to :color
  belongs_to :brand
  has_one :sell_item

  belongs_to :category

  # has_many :item_categories, dependent: :destroy
  # has_many :categories, through: :item_categories

  enum item_status: {
    on_keep:   0,
    discarded: 1,
    on_sell:   2
  }
  enum size: {
    S: 0,
    M: 1,
    L: 2
  }
end
