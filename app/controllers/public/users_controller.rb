class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @items = Item.where(user_id: current_user.id, item_status: "on_keep")
  end

  def edit
    @user = current_user
  end

  def unsubscribe
  end

  def update
    user = current_user
    if user.update(user_params)
      redirect_to(user_path(current_user))
    end
  end
  
  def rate
    @user = User.find(params[:id])
    @sell_items = @user.sell_items
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
