class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "編集が完了しました。"
      redirect_to admin_items_path
    else
      flash.now[:danger] = "編集ができませんでした。"
      render 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      flash[:success] = "正常に削除されました。"
      redirect_to admin_items_path
    else
      flash.now[:danger] = "削除できませんでした。"
      @items = Item.all
      render 'index'
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :color_id,
      :brand_id,
      :category_id,
      :price,
      :item_image,
      :purchase_date,
      :size,
      :name,
      :item_status,
      :wear_count
      )
  end
end
