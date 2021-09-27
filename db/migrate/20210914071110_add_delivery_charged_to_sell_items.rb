class AddDeliveryChargedToSellItems < ActiveRecord::Migration[5.2]
  def change
   add_column :sell_items, :delivery_charged, :integer, null: false, default: 0
   add_column :sell_items, :delivery_days, :integer, null: false, default: 0
   add_column :sell_items, :delivery_way, :integer, null: false, default: 0
  end
end
