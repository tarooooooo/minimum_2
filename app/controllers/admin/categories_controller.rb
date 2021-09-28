class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @categories = Category.all
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @categories = Category.all
    @category = Category.new
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "登録完了しました。"
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = "登録ができませんでした。"
      render 'index'
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "編集が完了しました。"
      redirect_to admin_categories_path
    else
      flash.now[:danger] = "編集ができませんでした。"
      render 'edit'
    end
  end

  def destroy
    category = Category.find(params[:id])
    if category.destroy
      redirect_back(fallback_location: root_path)
    end
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end
end
