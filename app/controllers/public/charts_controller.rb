class Public::ChartsController < ApplicationController
  def purchase
    @items = current_user.items
    @categories = current_user.categories.group(:id)
  end

  def disposal
    @items = Item.where(user_id: current_user.id, item_status: 1)
    @color_codes = []
    @chartkick_brand_items = []
    @chartkick_category_items = []
    @category_color_codes = []
    @items.each do |item|
      @color_codes.push(item.color.color_code)
    end

    # group の引数がストリングの場合(Sqlite / MySQL)のそのままのtablenameを指定する
    @chartkick_items = @items.joins(:color).group('colors.name').count
    @chartkick_brands_items = @items.joins(:brand).group('brands.name').count
    # color code をDBに入れられれば以下の処理は不要
    # Color.all.map(&:name).each do |color_name|
      # 後置if/unless
      # @chartkick_items.store(color_name, 0) unless @chartkick_items.include?(color_name)
    # end
    @chartkick_items = @chartkick_items.sort
    # @chartkick_items = [['black', 12],['white',0],['yellow', 5]]
    # @categories = @items.joins(:category).group('categories.id').pluck("categories.id","categories.name")
    @categories = @items.joins(:category).group('categories.id').select("categories.id","categories.name")

    @categories.each do |category|
      @chartkick_category_items[category.id] = @items.joins(:color).where(category_id: category.id).group('colors.name').count
      @chartkick_brand_items[category.id] = @items.joins(:brand).where(category_id: category.id).group('brands.name').count
      #pp @chartkick_category_items[category.id]
      # {"白"=>1, "青"=>1}
       @category_color_codes[category.id] = []
      # 二次元配列の初期化
       @chartkick_category_items[category.id].each do |item|
         # item[0] = [色]
       color = Color.find_by(name: item[0])
      # 色の名前からカラーコードを取るため
       @category_color_codes[category.id].push(color.color_code)
       end
    end
  end

  def index
  end
end
