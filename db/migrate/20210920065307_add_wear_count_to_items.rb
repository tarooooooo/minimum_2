class AddWearCountToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :wear_count, :integer, default: false, null: false
  end
end
