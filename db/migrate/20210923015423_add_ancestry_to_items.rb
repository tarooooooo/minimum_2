class AddAncestryToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :ancestry, :string
  end
end
