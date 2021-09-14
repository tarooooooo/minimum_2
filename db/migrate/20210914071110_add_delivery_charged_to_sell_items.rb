class AddDeliveryChargedToSellItems < ActiveRecord::Migration[5.2]
  def change
    add_column :sell_items, :delivery_charged, :integer
    add_column :sell_items, :delivery_days, :integer
    add_column :sell_items, :delivery_way, :integer
  end
end
