class RemoveAgeFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :age, :string
  end
end
