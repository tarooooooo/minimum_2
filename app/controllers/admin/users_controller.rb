class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "編集が完了しました。"
      redirect_to admin_user_path(@user.id)
    else
      flash.now[:danger] = "編集ができませんでした。"
      render 'edit'
    end
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
      :email,
      :is_deleted
      )
  end
end
