class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :sell_item, type: :bigint, foreign_key: true, null: false
      t.references :user, type: :bigint, foreign_key: true, null: false
      t.text :text, null: false

      t.timestamps
    end
  end
end
