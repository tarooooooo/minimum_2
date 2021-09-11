class Public::ItemsController < ApplicationController

  def new
   #セレクトボックスの初期値設定
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
    @item = Item.new
  end

  def index
    @items = Item.where(user_id: current_user.id)
    @categories = Category.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    item = Item.new(item_params)
    item.user_id = current_user.id
    category = item.category
    if category.items.count < category.category_management.limit.to_i
      if item.save
        redirect_to item_path(item)
      end
    else
      redirect_to items_path
    end
  end

  def update
    item = Item.find(params[:id])

    if item_params[:item_status] == "discarded"
      item.discard_date = Date.today.to_time
    end
    if item.update(item_params)
      redirect_to item_path(item)
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.destroy
      redirect_to items_path
    end
  end

  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

   # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
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
      :item_status
      )
  end
end
