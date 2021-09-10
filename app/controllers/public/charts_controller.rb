class Public::ChartsController < ApplicationController
  def purchase
    @items = current_user.items
  end

  def disposal
  end

  def index
  end
end
