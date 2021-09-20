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
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    category = @item.category

    if category.category_managements.find_by(user_id: current_user.id) == nil
       flash.now[:danger] = "#{@item.category.name}の、制限が設定されていません"
      render 'public/items/new'
    else
      # 登録しようとしているitemのlimit
      limit = category.category_managements.find_by(user_id: current_user.id).limit.to_i
      # 登録しようとしているitemのカテゴリにすでに登録されている件数
      items_count = category.items.where(user_id: current_user.id).count

      if items_count < limit
        if @item.save
          redirect_to item_path(@item)
        end
      else
        flash.now[:danger] = "#{@item.category.name}が制限に達しました。（#{@item.category.name}の設定数：#{limit}個）"
        render 'public/items/new'
      end
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

  def item_status_change
    @items = if params[:item_status] == "on_keep"
               current_user.items.on_keep
             elsif params[:item_status] == "discarded"
               current_user.items.discarded
             elsif params[:item_status] == "on_sell"
               current_user.items.on_sell
             end
    render 'public/items/index'
  end

  def wear_today_new
    @items = current_user.items.where(item_status: "on_keep")
    @top_items = @items.order('wear_count desc').limit(3)
    @worst_items = @items.order('wear_count asc').limit(3)
    @categories = []
    @items.each do |item|
      @categories << item.category
    end
    @categories.uniq!
  end

  def wear_today_update
    item = Item.find(params[:id])
    item.wear_count += 1
    item.save
    redirect_back(fallback_location: root_path)
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
      :item_status,
      :wear_count
      )
  end
end
