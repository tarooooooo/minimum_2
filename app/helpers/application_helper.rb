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

      items = current_user.items.where(category_id: category.id, item_status: "discarded")
      price_items = Item.prices_count(items)
      
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
