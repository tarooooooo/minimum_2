class CreateSellItems < ActiveRecord::Migration[5.2]
  def change
    create_table :sell_items do |t|
      t.string :name
      t.string :sell_item_image_id
      t.integer :buyer_id
      t.integer :seller_id, null: false
      t.references :item, type: :bigint, foreign_key: true, null: false
      t.string :order_price, null: false
      t.string :delivery_price, null: false
      t.integer :payment_method, default: 0, null: false
      t.integer :order_status, default: 0, null: false
      t.datetime :buy_date
      t.text :introduction

      t.timestamps
    end
  end
end
