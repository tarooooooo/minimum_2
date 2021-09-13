class CreateCategoryManagements < ActiveRecord::Migration[5.2]
  def change
    create_table :category_managements do |t|
      t.references :category, type: :bigint, foreign_key: true
      t.references :user, type: :bigint, foreign_key: true
      t.string :limit

      t.timestamps
    end
  end
end
