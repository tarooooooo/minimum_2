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
    @inner_items = @items.where(category_id: 1)
    @outer_items = @items.where(category_id: 2)
    @bottoms_items = @items.where(category_id: 3)
    # カラーコードの空の配列
    @color_codes = []
    # ブランド別のアイテムの空の配列
    @brand_items = []
    # 価格別のアイテムのからの配列
    @price_items = []
    # カラー別のアイテムの空の配列
    @color_items = []
    @category_color_items = []
    @category_brand_items = []
    @category_price_items = []
    @high_chart_by_category_color = []
    @high_chart_by_category_brand = []
    @high_chart_by_category_price = []
    # カテゴリー別のアイテムの空の配列
    @category_color_codes = []

    @colors = @items.joins(:color).group('colors.name').count
    @colors = @colors.sort_by{|key,val| -val}.to_h
    @color_names = @colors.keys.first(10)
    @genre = "color"


    @targets = []
    @target = "color"

    @color_names.each do |name|
      @targets << Color.find_by(name: name)
    end

    @brands = @items.joins(:brand).group('brands.name').count
    @brands = @brands.sort_by{|key,val| -val}.to_h
    @brand_names = @brands.keys.first(10)
    @brands = []
    @brand_names.each do |name|
      @brands << Brand.find_by(name: name)
    end

    # end
    # group の引数がストリングの場合(Sqlite / MySQL)のそのままのtablenameを指定する
    @color_items_h = @items.joins(:color).order('count_all desc').group('colors.name').count
    @color_items = @items.joins(:color).order('count_all desc').group('colors.name').count.to_a
    # @inner_items_by_color = @inner_items.joins(:color).order('count_all desc').group('colors.name').count.to_a
    # @outer_items_by_color = @outer_items.joins(:color).order('count_all desc').group('colors.name').count.to_a
    # @bottoms_items_by_color = @bottoms_items.joins(:color).order('count_all desc').group('colors.name').count.to_a

    @high_chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'カラー別')
      f.series(name: "個数" ,data: @color_items, type: 'pie')
    end

    @color_items_h.each_key { |key|
      color = Color.find_by(name: key)
      # 色の名前からカラーコードを取るため
      @color_codes.push(color.color_code)
    }


    # ブランド別highcharts
    @brands_items = @items.joins(:brand).order('count_all desc').group('brands.name').count.to_a
    @high_chart_by_brand = LazyHighCharts::HighChart.new('graph') do |f|
       f.title(text: 'ブランド別')
       f.series(name: "個数", data: @brands_items, type: 'pie')
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

    @price_items = {'0~1000円': from_0_to_1000.size,
                    '1001~3000円': from_1001_to_3000.size,
                    '3001~5000円': from_3001_to_5000.size,
                    '5001~10000円': from_5001_to_10000.size,
                    '10001~20000円': from_10001_to_20000.size,
                    '20001~30000円': from_20001_to_30000.size,
                    '30000円~': over_30001.size
                    }

    @prices = ['0~1000円', '1001~3000円', '3001~5000円', '5001~10000円', '10001~20000円', '20001~30000円', '30000円~']
    # 価格別highcharts
    @price_items = @price_items.sort_by{|key,val| -val}.to_a
    @high_chart_by_price = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: '価格別')
      f.series(name: "個数",data: @price_items, type: 'pie')
    end

    # カテゴリーをアイテムから取り出す
    @categories = []
    @items.each do |item|
      @categories << item.category
    end
    @categories.uniq!

    from_0_to_1000      = []
    from_1001_to_3000   = []
    from_3001_to_5000   = []
    from_5001_to_10000  = []
    from_10001_to_20000 = []
    from_20001_to_30000 = []
    over_30001          = []

    @category_price_items = []
    @categories.each do |category|

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

      @category_price_items[category.id] = { '0~1000円': from_0_to_1000[category.id].size,
                                  '1001~3000円': from_1001_to_3000[category.id].size,
                                  '3001~5000円': from_3001_to_5000[category.id].size,
                                  '5001~10000円': from_5001_to_10000[category.id].size,
                                  '10001~20000円': from_10001_to_20000[category.id].size,
                                  '20001~30000円': from_20001_to_30000[category.id].size,
                                  '30000円~': over_30001[category.id].size
                                  }

      @category_color_items[category.id] = @items.joins(:color).where(category_id: category.id).group('colors.name').count
      @category_brand_items[category.id] = @items.joins(:brand).where(category_id: category.id).group('brands.name').count

      # {"白"=>1, "青"=>1}
      @category_color_codes[category.id] = []
      # 二次元配列の初期化
      @category_color_items[category.id].each do |item|
        # item[0] = [色]
        color = Color.find_by(name: item[0])
        # 色の名前からカラーコードを取るため
        @category_color_codes[category.id].push(color.color_code)
      end

      # valueの降順にする
      @category_price_items[category.id] = @category_price_items[category.id].sort_by{|key,val| -val}
      @category_color_items[category.id] = @category_color_items[category.id].sort_by{|key,val| -val}
      @category_brand_items[category.id] = @category_brand_items[category.id].sort_by{|key,val| -val}

      @high_chart_by_category_color[category.id] = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: 'カラー別')
        f.series(name: "個数", data: @category_color_items[category.id], type: 'pie')
      end

      @high_chart_by_category_brand[category.id] = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: 'ブランド別')
        f.series(name: "個数", data: @category_brand_items[category.id], type: 'pie')
      end

      @high_chart_by_category_price[category.id] = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: '価格別')
        f.series(name: "個数", data: @category_price_items[category.id], type: 'pie')
      end

    end
  end

  def next
    @items = Item.where(user_id: current_user.id, item_status: 1)
    genre = params[:genre]
    if genre.nil? || genre ==  "color"
      @genre = "brand"
      @brands_items = @items.joins(:brand).order('count_all desc').group('brands.name').count.to_a
      @high_chart = LazyHighCharts::HighChart.new('graph') do |f|
         f.title(text: 'ブランド別')
         f.series(name: "個数", data: @brands_items, type: 'pie')
      end
   
    elsif genre == "brand"
  
      @genre = "price"
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

      @price_items = {'0~1000円': from_0_to_1000.size,
                      '1001~3000円': from_1001_to_3000.size,
                      '3001~5000円': from_3001_to_5000.size,
                      '5001~10000円': from_5001_to_10000.size,
                      '10001~20000円': from_10001_to_20000.size,
                      '20001~30000円': from_20001_to_30000.size,
                      '30000円~': over_30001.size
                      }
      @price_items = @price_items.sort_by{|key,val| -val}.to_a
      @high_chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: '価格別')
        f.series(name: "個数",data: @price_items, type: 'pie')
      end
    else
      @genre = "color"
           @color_items = @items.joins(:color).order('count_all desc').group('colors.name').count.to_a
    # @inner_items_by_color = @inner_items.joins(:color).order('count_all desc').group('colors.name').count.to_a
    # @outer_items_by_color = @outer_items.joins(:color).order('count_all desc').group('colors.name').count.to_a
    # @bottoms_items_by_color = @bottoms_items.joins(:color).order('count_all desc').group('colors.name').count.to_a

    @high_chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'カラー別')
      f.series(name: "個数" ,data: @color_items, type: 'pie')
    end
    end



    @colors = @items.joins(:color).group('colors.name').count
    @colors = @colors.sort_by{|key,val| -val}.to_h
    @color_names = @colors.keys.first(10)
    @targets = []

    @color_names.each do |name|
      @targets << Color.find_by(name: name)
    end
      @brands = @items.joins(:brand).group('brands.name').count
    @brands = @brands.sort_by{|key,val| -val}.to_h
    @brand_names = @brands.keys.first(10)
    @brands = []
    @brand_names.each do |name|
      @brands << Brand.find_by(name: name)
    end
     @prices = ['0~1000円', '1001~3000円', '3001~5000円', '5001~10000円', '10001~20000円', '20001~30000円', '30000円~']

  end
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  def back
    @items = Item.where(user_id: current_user.id, item_status: 1)
    genre = params[:genre]
    if genre.nil? || genre ==  "color"
      @genre = "price"
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

      @price_items = {'0~1000円': from_0_to_1000.size,
                      '1001~3000円': from_1001_to_3000.size,
                      '3001~5000円': from_3001_to_5000.size,
                      '5001~10000円': from_5001_to_10000.size,
                      '10001~20000円': from_10001_to_20000.size,
                      '20001~30000円': from_20001_to_30000.size,
                      '30000円~': over_30001.size
                      }
      @price_items = @price_items.sort_by{|key,val| -val}.to_a
      @high_chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: '価格別')
        f.series(name: "個数",data: @price_items, type: 'pie')
      end
      
    elsif genre == "brand"
      
      @genre = "color"
      @color_items = @items.joins(:color).order('count_all desc').group('colors.name').count.to_a
      @high_chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: 'カラー別')
        f.series(name: "個数" ,data: @color_items, type: 'pie')
      end
      
    else
      
      @genre = "brand"
      @brands_items = @items.joins(:brand).order('count_all desc').group('brands.name').count.to_a
      @high_chart = LazyHighCharts::HighChart.new('graph') do |f|
         f.title(text: 'ブランド別')
         f.series(name: "個数", data: @brands_items, type: 'pie')
      end
      
    end
    @colors = @items.joins(:color).group('colors.name').count
    @colors = @colors.sort_by{|key,val| -val}.to_h
    @color_names = @colors.keys.first(10)
    @targets = []

    @color_names.each do |name|
      @targets << Color.find_by(name: name)
    end
    @brands = @items.joins(:brand).group('brands.name').count
    @brands = @brands.sort_by{|key,val| -val}.to_h
    @brand_names = @brands.keys.first(10)
    @brands = []
    @brand_names.each do |name|
      @brands << Brand.find_by(name: name)
    end
     @prices = ['0~1000円', '1001~3000円', '3001~5000円', '5001~10000円', '10001~20000円', '20001~30000円', '30000円~']
  end
end
