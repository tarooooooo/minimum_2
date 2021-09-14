class Public::CommentsController < ApplicationController
  def create
    sell_item = SellItem.find(params[:sell_item_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.sell_item_id = sell_item.id
    comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_back(fallback_location: root_path)
  end
  
  private
   
  def comment_params
    params.require(:comment).permit(:text)
  end
end
