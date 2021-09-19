class Admin::SellItemsController < ApplicationController
  def index
    @sell_items = SellItem.all
  end

  def show
    @sell_item = SellItem.find(params[:id])
  end

  def update
    @sell_item = SellItem.find(params[:id])
    if @sell_item.update(order_status: "wait_shipping")
       redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "不正な処理が行われました。"
      redirect_back(fallback_location)
    end
  end
  
end
