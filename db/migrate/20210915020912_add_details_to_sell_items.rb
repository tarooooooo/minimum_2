class AddDetailsToSellItems < ActiveRecord::Migration[5.2]
  def change
    add_column :sell_items, :rate, :float, default: 0
    add_column :sell_items, :rating_comment, :string
  end
end
