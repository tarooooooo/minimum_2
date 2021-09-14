class CreateSellItemComments < ActiveRecord::Migration[5.2]
  def change
    create_table :sell_item_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :sell_item_id

      t.timestamps
    end
  end
end
