class RemoveColumnCommentIdFromNotification < ActiveRecord::Migration[5.2]
  def change
    remove_index :notifications, :comment_id
    remove_reference :notifications, :comment
  end
end
