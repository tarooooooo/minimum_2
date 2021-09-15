class Public::SellItemsController < ApplicationController

  def index
    @sell_items = SellItem.all
  end

  def show
    @sell_item = SellItem.find(params[:id])
    @like = Like.new
    @comment = Comment.new
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
    @sell_item = SellItem.find(params[:id])
    cookies[:payment_method] = params[:sell_item][:payment_method]
    @payment_method = I18n.t('enums.sell_item.payment_method')[params[:sell_item][:payment_method].to_sym]
  end

  # def order_confirm_error;end

  def order_complete
    @sell_item = SellItem.find(params[:id])
    if cookies[:payment_method].present?
      if @sell_item.update(payment_method: cookies[:payment_method])
        @sell_item.buyer_id = current_user.id
        @sell_item.buy_date = Date.today
        @sell_item.order_status = :wait_shipping
        @sell_item.save
        cookies.delete :payment_method
      end
    end
  end

  def order_status_update
    @sell_item = SellItem.find(params[:id])
    @sell_item.order_status = params[:order_status]
    @sell_item.save
    redirect_back(fallback_location: root_path)
  end

  private

  def order_status_params
    params.require(:sell_item).permit(:order_status)
  end

  def sell_item_params
    params.require(:sell_item).permit(
      :sell_item_image,
      :name,
      :item_id,
      :order_price,
      :payment_method,
      :introduction,
      :delivery_charged,
      :delivery_way,
      :delivery_days,
      :order_status
      )
  end
end
