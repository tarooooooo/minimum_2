class CreateSellItems < ActiveRecord::Migration[5.2]
  def change
    create_table :sell_items do |t|
      t.integer :buyer_id, null: false
      t.integer :seller_id, null: false
      t.string :item_image_id, null: false
      t.string :name, null: false
      t.string :order_price, null: false
      t.string :delivery_price, null: false
      t.references :brand, foreign_key: true, null: false
      t.references :color, foreign_key: true, null: false
      t.integer :order_status, null: false
      t.integer :payment_method, null: false
      t.datetime :purchase_date, null: false
      t.integer :size, null: false

      t.timestamps
    end
  end
end
