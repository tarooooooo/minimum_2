class Public::SellItemsController < ApplicationController

  def myitems_by_sell
    @sell_items = SellItem.where(seller_id: current_user.id)
  end

  def myitems_by_order
    @sell_items = SellItem.where(buyer_id: current_user.id)
  end

  def myitems_by_order_status
   if params[:order_status] == "now_trading_by_order"
     @sell_items =  SellItem.where(buyer_id: current_user.id).where( order_status: ['payment_waiting','wait_shipping','shipped'])
     render 'public/sell_items/myitems_by_order'
   elsif params[:order_status] == "close_of_trading_by_order"
      @sell_items = SellItem.where(buyer_id: current_user.id, order_status: "close_of_trading" )
     render 'public/sell_items/myitems_by_order'
   elsif params[:order_status] == "on_sell"
      @sell_items = SellItem.where(seller_id: current_user.id, order_status: "on_sell" )
      render 'public/sell_items/myitems_by_sell'
   elsif params[:order_status] == "now_trading_by_sell"
      @sell_items = SellItem.where(seller_id: current_user.id).where( order_status: ['payment_waiting','wait_shipping','shipped'])
      render 'public/sell_items/myitems_by_sell'
   elsif params[:order_status] == "close_of_trading_by_sell"
      @sell_items = SellItem.where(seller_id: current_user.id, order_status: "close_of_trading")
      render 'public/sell_items/myitems_by_sell'
   end
  end

  def index
    @sell_items = SellItem.where(order_status: "on_sell")
  end

  def show
    @sell_item = SellItem.find(params[:id])
    @like = Like.new
    @comment = Comment.new
    @comments = @sell_item.comments.order(created_at: :desc)
  end

  def new
    @item = Item.find(params[:item_id])
    @sell_item = SellItem.new
  end

  def create
    sell_item = SellItem.new(sell_item_params)
    sell_item.seller_id = current_user.id

    if sell_item.save(validate: false)
      item = sell_item.item
      item.item_status = "on_sell"
      item.save
      redirect_to sell_items_path
    end
  end

  def edit
    @sell_item = SellItem.find(params[:id])
  end

  def update
    sell_item = SellItem.find(params[:id])
    if sell_item.update!(sell_item_params)
      redirect_to sell_item_path(sell_item.id)
    end
  end

  def force_to_update
    sell_item = SellItem.find(params[:id])
    if sell_item.update!(sell_item_params)
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

  def order_finish
    @sell_item = SellItem.find(params[:id])
    if cookies[:payment_method].present?
      @sell_item.update(buy_item_params)
      cookies.delete :payment_method
      # 通知機能の記述
      @sell_item.create_notification_buy!(current_user)
      NotificationMailer.send_mail(@sell_item.buyer, @sell_item).deliver_now
      redirect_to sell_items_order_complete_path(params[:id])
    else
       不正な遷移
       redirect_to root_path, notice: '不正な遷移は許可されていません'
    end
  end

  def order_complete
    @sell_item = SellItem.find(params[:id])
  end

  def order_rate
    @sell_item = SellItem.find(params[:id])
  end

  def order_rate_update
    @sell_item = SellItem.find(params[:id])
    if @sell_item.update(rate_item_params)
      flash[:seccess] = "取引が完了しました。"
      redirect_to sell_item_path(@sell_item)
    else
      flash[:danger] = "評価してください。"
      render 'public/sell_items/order_rate'
    end
  end

  def order_status_update
    @sell_item = SellItem.find(params[:id])
    if @sell_item.update!(order_status: params[:order_status])
    redirect_back(fallback_location: root_path)
    end
  end

  def search
    redirect_to sell_items_path if params[:keyword] == ""

    split_keyword = params[:keyword].split(/[[:blank:]]+/)

    brands = []
    split_keyword.each do |keyword|
    next if keyword == ""
    brands += Brand.where('name LIKE(?)', "%#{keyword}%")
    end
    brands.flatten!

    @sell_items = []
    split_keyword.each do |keyword|
    next if keyword == ""
    @sell_items += SellItem.where('name LIKE(?) and order_status LIKE(?)', "%#{keyword}%", 0)
    end

  end

  private

  def order_status_params
    params.require(:sell_item).permit(:order_status)
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

  def buy_item_params
    {
      buyer_id: current_user.id,
      buy_date: Date.today,
      order_status: :payment_waiting,
      payment_method: cookies[:payment_method]
    }
  end

  def rate_item_params
     params.require(:sell_item).permit(
      :rate,
      :rating_comment,
      :order_status
       )
  end
end
