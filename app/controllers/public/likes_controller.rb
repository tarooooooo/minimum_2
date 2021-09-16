class Public::LikesController < ApplicationController
  
  def create
    @like = current_user.likes.create(sell_item_id: params[:sell_item_id])
    redirect_back(fallback_location: root_path)
    sell_item = SellItem.find(params[:sell_item_id])
    sell_item.create_notification_like!(current_user)
  end

  def destroy
    @like = Like.find_by(sell_item_id: params[:sell_item_id], user_id: current_user.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end
  
end
