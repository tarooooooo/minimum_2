class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @sell_items = SellItem.where(seller_id: @user.id, order_status: "on_sell")
    @current_sell_now = SellItem.where(seller_id: @user.id, buyer_id: current_user.id ).where( order_status: ['payment_waiting','wait_shipping','shipped'])
    @user_sell_now = SellItem.where(seller_id: current_user.id, buyer_id: @user.id ).where( order_status: ['payment_waiting','wait_shipping','shipped'])
    # byebug
    # チャット機能
    # Entryモデルからログインユーザーのレコードを抽出
    @current_entry = Entry.where(user_id: current_user.id)
    # Entryモデルからメッセージ相手のレコードを抽出
    @another_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_entry.each do |current_entry|
        @another_entry.each do |another_entry|
          # ルームが存在する場合
          if current_entry.room_id == another_entry.room_id
            @is_room = true
            @room_id = current_entry.room_id
          end
        end
      end
      # ルームが存在しない場合は新規作成
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end

    # 評価の表示
    @sell_items = SellItem.where(seller_id: @user.id, order_status: "close_of_trading")
    @user_rate = SellItem.where(seller_id: @user.id, order_status: "close_of_trading" ).pluck(:rate)
    @user_rate_avg = @user_rate.sum.fdiv(@user_rate.length).round(1)
  end

  def edit
    @user = current_user
  end

  def unsubscribe
  end

  def update
    user = current_user
    if user.update(user_params)
      redirect_to(detail_user_path(current_user))
    end
  end

  def likes
    @user = User.find(params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def rate
    @user = User.find(params[:id])
    @sell_items = SellItem.where(seller_id: @user.id, order_status: "close_of_trading").sort.reverse
    @user_rate = SellItem.where(seller_id: @user.id, order_status: "close_of_trading" ).pluck(:rate)
    @user_rate_avg = @user_rate.sum.fdiv(@user_rate.length).round(1)

  end

  def detail
  end

  def withdraw
  end

  private

  def user_params
    params.require(:user).permit(
      :nickname,
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :postal_code,
      :address,
      :phone_number,
      :age,
      :icon_image,
      :is_deleted
      )
  end



end
