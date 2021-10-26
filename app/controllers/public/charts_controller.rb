class Public::ChartsController < ApplicationController
   before_action :authenticate_user!

  def purchase
    @items = current_user.items
    @categories = current_user.categories.group(:id)

    @inner_items = current_user.items.where(category_id: 1)
    @outer_items = current_user.items.where(category_id: 2)
    @bottoms_items = current_user.items.where(category_id: 3)
  end

  def disposal #ここにgenreを飛ばすように
    @items = Item.where(user_id: current_user.id, item_status: 1)
    @category = params[:category]
    # itemに紐づくカテゴリーを取り出す
    @categories = []
    @items.each do |item|
      @categories << item.category
    end
    @categories.uniq!
    
    genre = params[:genre]
    @genres = []
    if genre.nil? || genre == "color"
      @genre = "brand"
      # genres_create
      @genres = Brand.genres_create(@items)

      brands_items = @items.joins(:brand).order('count_all desc').group('brands.name').count.to_a

      @high_chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: 'ブランド別')
        f.series(name: "個数", data: brands_items, type: 'pie')
      end

    elsif genre == "brand"

      @genre = "price"
      # genres_create
      @genres = ['0~1000円', '1001~3000円', '3001~5000円', '5001~10000円', '10001~20000円', '20001~30000円', '30000円~']
      # ハッシュを作る
      price_items = Item.prices_count(@items)
      # ハッシュを配列にする
      price_items = price_items.sort_by{|key,val| -val}.to_a
      # high_chart_create
      @high_chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: '価格別')
        f.series(name: "個数",data: price_items, type: 'pie')
      end

    elsif genre == "price"
      @genre = "color"
      # genres_create
      @genres = Color.genres_create(@items)
      # high_chart_create
      color_items = @items.joins(:color).order('count_all desc').group('colors.name').count.to_a
      @high_chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: 'カラー別')
        f.series(name: "個数" ,data: color_items, type: 'pie')
      end
    end
    @category = params[:category]
  end


end
