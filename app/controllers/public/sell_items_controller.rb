class Public::SellItemsController < ApplicationController

  def index
    @sell_items = SellItem.all
  end

  def show
    @sell_item = SellItem.find(params[:id])
    @like = Like.new
  end

  def new
    @item = Item.find(params[:item_id])
    @sell_item = SellItem.new
  end

  def create
    sell_item = SellItem.new(sell_item_params)
    sell_item.seller_id = current_user.id
    if sell_item.save
      redirect_to sell_items_path
    end
  end

  def edit
    @sell_item = SellItem.find(params[:id])
  end

  def update
    sell_item = SellItem.find(params[:id])
    if sell_item.update(sell_item_params)
      redirect_to sell_item_path(sell_item.id)
    end
  end

  def destroy
    sell_item = SellItem.find(params[:id])
    if sell_item.destroy
      redirect_to items_path
    end
  end

  def order_new
    @sell_item = SellItem.find(params[:id])
  end

  def order_confirm
  end

  def order_complete
  end

  private

  def sell_item_params
    params.require(:sell_item).permit(
      :sell_item_image,
      :name,
      :item_id,
      :order_price,
      :delivery_price,
      :introduction,
      :delivery_charged,
      :delivery_way,
      :delivery_days
      )
  end
end
