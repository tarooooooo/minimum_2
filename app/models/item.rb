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


  with_options presence: true do
    validates :name, length: { minimum: 1, maximum: 20 }
    validates :size
    validates :item_status
    validates :purchase_date
    validates :wear_count
    validates :item_image
  end
  validates :price,
    numericality: {
      greater_than_or_equal_to: 100,
      less_than: 1000000
    }

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

  def self.prices_count(items)
      from_0_to_1000      = []
      from_1001_to_3000   = []
      from_3001_to_5000   = []
      from_5001_to_10000  = []
      from_10001_to_20000 = []
      from_20001_to_30000 = []
      over_30001          = []
      items.each do |item|
        from_0_to_1000      << item if (0..1_000).cover?(item.price.to_i)
        from_1001_to_3000   << item if (1_001..3_000).cover?(item.price.to_i)
        from_3001_to_5000   << item if (3_001..5_000).cover?(item.price.to_i)
        from_5001_to_10000  << item if (5_001..10_000).cover?(item.price.to_i)
        from_10001_to_20000 << item if (10_001..20_000).cover?(item.price.to_i)
        from_20001_to_30000 << item if (20_001..30_000).cover?(item.price.to_i)
        over_30001          << item if (30_001..).cover?(item.price.to_i)
      end

      price_items = {'0~1000円': from_0_to_1000.size,
                     '1001~3000円': from_1001_to_3000.size,
                     '3001~5000円': from_3001_to_5000.size,
                     '5001~10000円': from_5001_to_10000.size,
                     '10001~20000円': from_10001_to_20000.size,
                     '20001~30000円': from_20001_to_30000.size,
                     '30000円~': over_30001.size
      }
      return price_items
  end
  
end
