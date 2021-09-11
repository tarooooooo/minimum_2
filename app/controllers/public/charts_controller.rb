class Public::ChartsController < ApplicationController
  def purchase
    @items = current_user.items
    @categories = Category.all
  end

  def disposal
    @items = Item.where(user_id: current_user.id, item_status: 1)

    @color_codes = Color.all.map(&:color_code)
    @color_codes = @color_codes.sort
    @color_codes.uniq!
    # group の引数がストリングの場合(Sqlite / MySQL)のそのままのtablenameを指定する
    @chartkick_items = Item.joins(:color).group('colors.name').count
    # color code をDBに入れられれば以下の処理は不要
    # Color.all.map(&:name).each do |color_name|
      # 後置if/unless
      # @chartkick_items.store(color_name, 0) unless @chartkick_items.include?(color_name)
    # end
    @chartkick_items = @chartkick_items.sort
    # @chartkick_items = [['black', 12],['white',0],['yellow', 5]]
  end

  def index
  end
end
