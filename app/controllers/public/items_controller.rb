class Public::ItemsController < ApplicationController
   before_action :authenticate_user!

  def new
   #セレクトボックスの初期値設定
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
    @item = Item.new
  end

  def index
    @items = Item.where(user_id: current_user.id, item_status: "on_keep" )
    # @items_image_url = []
    # @items.each do |item|
    #   @items_image_url << "https://mypfbucket-resize.s3-ap-northeast-1.amazonaws.com/store/" + item.item_image_id + "-thumbnail."
    # end
    @categories = Category.all
  end

  def show
    @item = Item.find(params[:id])
     # 参照先のS3オブジェクトURLを作成
    @item_image_url = "https://mypfbucket-resize.s3-ap-northeast-1.amazonaws.com/store/" + @item.item_image_id + "-thumbnail."
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
          flash[:success] = "登録が完了しました。"
          redirect_to item_path(@item)
        else
          flash.now[:danger] = "登録ができませんでした。"
          render 'public/items/new'
        end
      else
        flash.now[:danger] = "#{@item.category.name}が制限に達しました。（#{@item.category.name}の設定数：#{limit}個）"
        render 'public/items/new'
      end
    end
  end

  def update
    @item = Item.find(params[:id])

    if item_params[:item_status] == "discarded"
      @item.discard_date = Date.today.to_time
    end
    if @item.update(item_params)
      sleep(3) # S3への画像反映のタイムラグを考慮して3秒待機
      flash[:success] = "編集が完了しました。"
      redirect_to item_path(@item)
    else
       flash.now[:danger] = "編集内容が登録できませんでした。"
      render 'edit'
    end
  end

  def status_discarded
    @item = Item.find(params[:item_id])
    @item.item_status = "discarded"
    @item.discard_date = Date.today.to_time
    if @item.save
       flash[:success] = "アイテムを破棄しました。"
       redirect_to item_path(@item)
    else
      flash[:danger] = "正常に廃棄処理がされませんでした。"
      redirect_back(fallback_location: root_path)

    end
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
    respond_to do |format|
      format.html
      format.json do
        @children = Category.find(params[:parent_id], ancestry: nil).children
      end
    end
  end
  def get_category_grandchildren
    respond_to do |format|
      format.html
      format.json do
        @grandchildren = Category.find("#{params[:child_id]}").children
      end
    end
  end

  def by_months
    @categories = []
    case params[:date]
      when "current_month"
        @items = current_user.items.purchase_date_thismonth
      when "one_month_ago"
        @items = current_user.items.purchase_date_1month_ago
      when "two_month_ago"
        @items = current_user.items.purchase_date_2month_ago
      when "three_month_ago"
        @items = current_user.items.purchase_date_3month_ago
      when "four_month_ago"
        @items = current_user.items.purchase_date_4month_ago
      when "five_month_ago"
        @items = current_user.items.purchase_date_5month_ago
      when "six_month_ago"
        @items = current_user.items.purchase_date_6month_ago
      when "seven_month_ago"
        @items = current_user.items.purchase_date_7month_ago
      when "eight_month_ago"
        @items = current_user.items.purchase_date_8month_ago
      when "nine_month_ago"
        @items = current_user.items.purchase_date_9month_ago
      when "ten_month_ago"
        @items = current_user.items.purchase_date_10month_ago
      when "eleven_month_ago"
        @items = current_user.items.purchase_date_11month_ago
    end

    target = params[:target]

    if target.present?
      if target == "inner"
        @items = @items.where(category_id: 1)
      elsif target == "outer"
        @items = @items.where(category_id: 2)
      elsif target == "bottoms"
        @items = @items.where(category_id: 3)
      end
    end

    @items.each do |item|
      @categories << item.category
    end
    @categories.uniq!
  end

  def disposal
    # cateogry_id(0) = 全アイテム
    category_id = params[:category_id]

    if params[:color].present?

      @color = Color.find_by(name: params[:color])
      if category_id == "0"
        @items = current_user.items.where(item_status: "discarded", color_id: @color.id)
      else
        @items = current_user.items.where(item_status: "discarded", color_id: @color.id, category_id: category_id)
      end

    elsif params[:brand].present?

      @brand = Brand.find_by(name: params[:brand])
      if category_id == "0"
        @items = current_user.items.where(item_status: "discarded", brand_id: @brand.id)
      else
        @items = current_user.items.where(item_status: "discarded", brand_id: @brand.id, category_id: category_id)
      end

    elsif params[:price].present?
      @price = params[:price]
      if category_id == "0"
        @items = current_user.items.where(item_status: "discarded")
      else
        @items = current_user.items.where(item_status: "discarded", category_id: params[:target])
      end

      from_0_to_1000      = []
      from_1001_to_3000   = []
      from_3001_to_5000   = []
      from_5001_to_10000  = []
      from_10001_to_20000 = []
      from_20001_to_30000 = []
      over_30001          = []
      @items.each do |item|
        from_0_to_1000      << item if (0..1_000).cover?(item.price.to_i)
        from_1001_to_3000   << item if (1_001..3_000).cover?(item.price.to_i)
        from_3001_to_5000   << item if (3_001..5_000).cover?(item.price.to_i)
        from_5001_to_10000  << item if (5_001..10_000).cover?(item.price.to_i)
        from_10001_to_20000 << item if (10_001..20_000).cover?(item.price.to_i)
        from_20001_to_30000 << item if (20_001..30_000).cover?(item.price.to_i)
        over_30001          << item if (30_001..).cover?(item.price.to_i)
      end

      case params[:price]
        when "0~1000円"
          @items = from_0_to_1000
        when "1001~3000円"
          @items = from_1001_to_3000
        when "3001~5000円"
          @items = from_3001_to_5000
        when "5001~10000円"
          @items = from_5001_to_10000
        when "10001~20000円"
          @items = from_10001_to_20000
        when "20001~30000円"
          @items = from_20001_to_30000
        when "30000円~"
          @items = over_30001
      end
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
