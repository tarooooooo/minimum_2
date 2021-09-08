class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end
  
  def create
    category = Category.new(category_params)
    if category.save
      redirect_back(fallback_location: root_path)
    end
  end
  
  def update
    category = Category.find(params[:id])
    if category.update(category_params)
      redirect_to admin_categories_path
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
