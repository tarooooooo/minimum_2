class AddDeliveryChargedToSellItems < ActiveRecord::Migration[5.2]
  def change
    add_column :sell_items, :delivery_charged, :integer, null: false
    add_column :sell_items, :delivery_days, :integer, null: false
    add_column :sell_items, :delivery_way, :integer, null: false
  end
end
