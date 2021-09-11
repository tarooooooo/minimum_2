class CreateColors < ActiveRecord::Migration[5.2]
  def change
    create_table :colors do |t|
      t.string :name, null: false
      t.string :color_code, null: false
      
      t.timestamps
    end
  end
end
