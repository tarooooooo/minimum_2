class RemoveDeliveryPriceFromSellItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :sell_items, :delivery_price, :string
  end
end
