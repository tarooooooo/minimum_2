class CreateCategoryManagements < ActiveRecord::Migration[5.2]
  def change
    create_table :category_managements do |t|
      t.references :category, foreign_key: true
      t.references :user, foreign_key: true
      t.string :limit

      t.timestamps
    end
  end
end
