class Public::LikesController < ApplicationController
   before_action :authenticate_user!

  def create
    @sell_item = SellItem.find(params[:sell_item_id])
    @like = current_user.likes.build(sell_item_id: params[:sell_item_id])
    @like.save
    @sell_item.create_notification_like!(current_user)
    sell_item = SellItem.find(params[:sell_item_id])
    sell_item.create_notification_like!(current_user)
  end

  def destroy
    @sell_item = SellItem.find(params[:sell_item_id])
    like = Like.find_by(sell_item_id: params[:sell_item_id], user_id: current_user.id)
    like.destroy
  end
end
