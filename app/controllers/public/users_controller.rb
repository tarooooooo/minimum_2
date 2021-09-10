class Public::UsersController < ApplicationController
  def show
    @user = current_user
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
  
  def withdraw
  end
  
  private
  
  def user_params
    params.require(:user).permit(:sign_up, keys: [:nickname,:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:address,:phone_number,:age,:icon_image_id,:is_deleted])
  end
  
end
