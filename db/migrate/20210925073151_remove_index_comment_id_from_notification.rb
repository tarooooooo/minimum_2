class RemoveIndexCommentIdFromNotification < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :notifications, column: :comment_id
    remove_foreign_key :notifications, column: :sell_item_id
  end
end
