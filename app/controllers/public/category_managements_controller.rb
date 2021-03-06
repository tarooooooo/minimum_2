class Public::CategoryManagementsController < ApplicationController
   before_action :authenticate_user!
  
  def new
    @category_management = CategoryManagement.new
    @category_managements = CategoryManagement.where(user_id: current_user.id)
  end

  def edit
    @category_management = CategoryManagement.find(params[:id])
  end

  def create
    category_management = CategoryManagement.new(category_management_params)
    category_management.user_id = current_user.id
    @category_managements  = CategoryManagement.where(user_id: current_user.id)
    @category_management = CategoryManagement.new

    if category_management.save
      redirect_back(fallback_location: root_path)
    elsif category_management.category.nil?
      flash[:danger] = "値を入力してください"
      redirect_back(fallback_location: root_path)
    elsif category_management.present?
      flash[:danger] = "#{category_management.category.name}はすでに登録済みです。"
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    category_management = CategoryManagement.find(params[:id])
    if category_management.update(category_management_params)
      redirect_to new_category_management_path
    end
  end

  def destroy
    category_management = CategoryManagement.find(params[:id])
    if category_management.destroy
      redirect_to new_category_management_path
    end
  end

  private

  def category_management_params
    params.require(:category_management).permit(:category_id,:limit)
  end

end
