class Admin::SellItemsController < ApplicationController
  def index
    @sell_items = SellItem.all
  end

  def show
    @sell_item = SellItem.find(params[:id])
  end

  def update
    @sell_item = SellItem.find(params[:id])
    @sell_item.order_status = :on_sell
    @sell_item.save
    redirect_back(fallback_location: root_path)

  end
end
