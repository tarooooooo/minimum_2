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
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to admin_items_path
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.destroy
      redirect_to admin_items_path
    end
  end

end
