class Public::HomesController < ApplicationController
  def top
  end

  def about
    @sell_items = SellItem.where(order_status: 'on_sell')
  end
end
