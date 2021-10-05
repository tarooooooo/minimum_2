module ApplicationHelper

  def get_category_data(category_id, genre)
      category = Category.find(category_id)
    if genre == "color"
      brand_items = current_user.items.where(category_id: category_id).joins(:brand).order('count_all desc').group('brands.name').count.to_a
      high_chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: 'ブランド別')
        f.series(name: "個数" ,data: brand_items, type: 'pie')
      end
    elsif genre == "brand"

      from_0_to_1000      = []
      from_1001_to_3000   = []
      from_3001_to_5000   = []
      from_5001_to_10000  = []
      from_10001_to_20000 = []
      from_20001_to_30000 = []
      over_30001          = []
      from_0_to_1000[category.id]      = []
      from_1001_to_3000[category.id]   = []
      from_3001_to_5000[category.id]   = []
      from_5001_to_10000[category.id]  = []
      from_10001_to_20000[category.id] = []
      from_20001_to_30000[category.id] = []
      over_30001[category.id]          = []
      current_user.items.where(category_id: category.id, item_status: "discarded").each do |item|
        from_0_to_1000[category.id]      << item if (0..1_000).cover?(item.price.to_i)
        from_1001_to_3000[category.id]   << item if (1_001..3_000).cover?(item.price.to_i)
        from_3001_to_5000[category.id]   << item if (3_001..5_000).cover?(item.price.to_i)
        from_5001_to_10000[category.id]  << item if (5_001..10_000).cover?(item.price.to_i)
        from_10001_to_20000[category.id] << item if (10_001..20_000).cover?(item.price.to_i)
        from_20001_to_30000[category.id] << item if (20_001..30_000).cover?(item.price.to_i)
        over_30001[category.id]          << item if (30_001..).cover?(item.price.to_i)
      end

      price_items = { '0~1000円': from_0_to_1000[category.id].size,
                      '1001~3000円': from_1001_to_3000[category.id].size,
                      '3001~5000円': from_3001_to_5000[category.id].size,
                      '5001~10000円': from_5001_to_10000[category.id].size,
                      '10001~20000円': from_10001_to_20000[category.id].size,
                      '20001~30000円': from_20001_to_30000[category.id].size,
                      '30000円~': over_30001[category.id].size
                      }
      price_items = price_items.sort_by{|key,val| -val}
      high_chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: '価格別')
        f.series(name: "個数", data: price_items, type: 'pie')
      end

    elsif genre == "price"
      color_items = current_user.items.where(category_id: category_id).joins(:color).order('count_all desc').group('colors.name').count.to_a
      high_chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: 'カラー別')
        f.series(name: "個数" ,data: color_items, type: 'pie')
      end

    end

    return high_chart
  end
end
