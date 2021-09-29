class Admin::SellItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @sell_items = SellItem.all
  end

  def show
    @sell_item = SellItem.find(params[:id])
     @comments = @sell_item.comments.order(created_at: :desc)
  end

  def update
    @sell_item = SellItem.find(params[:id])
    if @sell_item.update(sell_item_params)
      redirect_back(fallback_location: root_path)
      flash[:success] = "変更を保存しました。"
    else
      flash[:danger] = "不正な処理が行われました。"
      redirect_back(fallback_location)
    end
  end

  def sell_item_params
    params.require(:sell_item).permit(
      :name,
      :item_id,
      :order_price,
      :payment_method,
      :introduction,
      :delivery_charged,
      :delivery_way,
      :delivery_days,
      :order_status,
      :rate,
      :rating_comment
      )
  end

end
