class Admin::BrandsController < ApplicationController
  def index
    @brands = Brand.all
    @brand = Brand.new
  end

  def edit
    @brand = Brand.find(params[:id])
  end
  
  def create 
    brand = Brand.new(brand_params)
    if brand.save
      redirect_back(fallback_location: root_path)
    end
  end
  
  def update
    brand = Brand.find(params[:id])
    if brand.update(brand_params)
      redirect_to admin_brands_path
    end
  end
  
  def destroy
    brand = Brand.find(params[:id])
    if brand.destroy
      redirect_back(fallback_location: root_path)
    end
  end
  
  private 
  
  def brand_params
    params.require(:brand).permit(:name)
  end
end
