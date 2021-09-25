class RemoveIndexSellItemIdFromNotification < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :notifications, :sell_items
    remove_index :notifications, :sell_item_id
    remove_reference :notifications, :sell_item
    add_column :notifications, :sell_item_id, :bigint
  end
end
