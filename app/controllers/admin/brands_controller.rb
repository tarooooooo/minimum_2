class Admin::BrandsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @brands = Brand.all
    @brand = Brand.new
  end

  def edit
    @brand = Brand.find(params[:id])
  end

  def create
    @brands = Brand.all
    @brand = Brand.new(brand_params)
    if @brand.save
      flash[:success] = "登録が完了しました。"
      redirect_back(fallback_location: root_path)
    else
      @brands = Brand.all
      flash.now[:danger] = "登録ができませんでした。"
      render 'admin/brands/index'
    end
  end

  def update
    @brand = Brand.find(params[:id])
    if @brand.update(brand_params)
      flash[:success] = "編集が完了しました。"
      redirect_to admin_brands_path
    else
      flash.now[:danger] = "編集ができませんでした。"
      render 'edit'
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
