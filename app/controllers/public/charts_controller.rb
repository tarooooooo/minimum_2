class Public::ChartsController < ApplicationController
   before_action :authenticate_user!

  def purchase
    @items = current_user.items
    @categories = current_user.categories.group(:id)

    @inner_items = current_user.items.where(category_id: 1)
    @outer_items = current_user.items.where(category_id: 2)
    @bottoms_items = current_user.items.where(category_id: 3)
  end

  def disposal
    @items = Item.where(user_id: current_user.id, item_status: 1)
    # カラーコードの空の配列
    @color_codes = []
    # ブランド別のアイテムの空の配列
    @chartkick_brand_items = []
    # 価格別のアイテムのからの配列
    @chartkick_items_by_price = []
    # カテゴリー別のアイテムの空の配列
    @chartkick_category_items = []
    # カテゴリー別のアイテムの空の配列
    @category_color_codes = []

    # group の引数がストリングの場合(Sqlite / MySQL)のそのままのtablenameを指定する
    @chartkick_items = @items.joins(:color).order('count_all desc').group('colors.name').count.to_a

     @chartkick_items = LazyHighCharts::HighChart.new('graph') do |f|
       f.title(text: 'カラー別')
       f.series(name: "個数" ,data: @chartkick_items, type: 'pie')
     end

    @chartkick_items.each_key { |key|
      color = Color.find_by(name: key)
      # 色の名前からカラーコードを取るため
      @color_codes.push(color.color_code)
    }
    # @chartkick_items = @chartkick_items.sort.to_h
    @chartkick_brands_items = @items.joins(:brand).order('count_all desc').group('brands.name').count.to_a

    @chartkick_brands_items = LazyHighCharts::HighChart.new('graph') do |f|
       f.title(text: 'ブランド別')
       f.series(name: "個数", data: @chartkick_brands_items, type: 'pie')
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

    @chartkick_items_by_price = { '0~1000円': from_0_to_1000.size,
                                  '1001~3000円': from_1001_to_3000.size,
                                  '3001~5000円': from_3001_to_5000.size,
                                  '5001~10000円': from_5001_to_10000.size,
                                  '10001~20000円': from_10001_to_20000.size,
                                  '20001~30000円': from_20001_to_30000.size,
                                  '30000円~': over_30001.size
                                  }
   @chartkick_items_by_price = @chartkick_items_by_price.sort_by{|key,val| -val}

    @chartkick_items_by_price = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '価格別')
      f.series(name: "個数",data: @chartkick_items_by_price, type: 'pie')
    end
    # color code をDBに入れられれば以下の処理は不要
    # Color.all.map(&:name).each do |color_name|
      # 後置if/unless
      # @chartkick_items.store(color_name, 0) unless @chartkick_items.include?(color_name)
    # end
    # @chartkick_items = [['black', 12],['white',0],['yellow', 5]]
    # @categories = @items.joins(:category).group('categories.id').pluck("categories.id","categories.name")
    @categories = @items.joins(:category).group('categories.id').select("categories.id","categories.name")
    @category_index = []
    @items.each do |item|
      @category_index << item.category
    end
    @category_index.uniq!
    from_0_to_1000      = []
    from_1001_to_3000   = []
    from_3001_to_5000   = []
    from_5001_to_10000  = []
    from_10001_to_20000 = []
    from_20001_to_30000 = []
    over_30001          = []

     @chartkick_category_items_by_price = []

    @category_index.each do |category|
      from_0_to_1000[category.id]      = []
      from_1001_to_3000[category.id]   = []
      from_3001_to_5000[category.id]   = []
      from_5001_to_10000[category.id]  = []
      from_10001_to_20000[category.id] = []
      from_20001_to_30000[category.id] = []
      over_30001[category.id]          = []
      category.items.where(user_id: current_user.id, item_status: "discarded").each do |item|
        from_0_to_1000[category.id]      << item if (0..1_000).cover?(item.price.to_i)
        from_1001_to_3000[category.id]   << item if (1_001..3_000).cover?(item.price.to_i)
        from_3001_to_5000[category.id]   << item if (3_001..5_000).cover?(item.price.to_i)
        from_5001_to_10000[category.id]  << item if (5_001..10_000).cover?(item.price.to_i)
        from_10001_to_20000[category.id] << item if (10_001..20_000).cover?(item.price.to_i)
        from_20001_to_30000[category.id] << item if (20_001..30_000).cover?(item.price.to_i)
        over_30001[category.id]          << item if (30_001..).cover?(item.price.to_i)
      end

      @chartkick_category_items_by_price[category.id] = {'0~1000円': from_0_to_1000[category.id].size,
                                                  '1001~3000円': from_1001_to_3000[category.id].size,
                                                  '3001~5000円': from_3001_to_5000[category.id].size,
                                                  '5001~10000円': from_5001_to_10000[category.id].size,
                                                  '10001~20000円': from_10001_to_20000[category.id].size,
                                                  '20001~30000円': from_20001_to_30000[category.id].size,
                                                  '30000円~': over_30001[category.id].size
                                                  }

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

      # valueの降順にする
      @chartkick_category_items_by_price[category.id] =  @chartkick_category_items_by_price[category.id].sort_by{|key,val| -val}
      @chartkick_category_items[category.id] =  @chartkick_category_items[category.id].sort_by{|key,val| -val}
      @chartkick_brand_items[category.id] = @chartkick_brand_items[category.id].sort_by{|key,val| -val}

      @chartkick_category_items[category.id] = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: 'カラー別')
        f.series(name: "個数", data: @chartkick_category_items[category.id], type: 'pie')
      end

      @chartkick_brand_items[category.id] = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: 'ブランド別')
        f.series(name: "個数", data: @chartkick_brand_items[category.id], type: 'pie')
      end

      @chartkick_category_items_by_price[category.id] = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: '価格別')
        f.series(name: "個数", data: @chartkick_category_items_by_price[category.id], type: 'pie')
      end
    end
  end

  def index
  end
end
