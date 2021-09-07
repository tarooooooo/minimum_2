class Admin::ColorsController < ApplicationController
  def index
    @color = Color.new
    @colors = Color.all
  end

  def edit
    @color = Color.find(params[:id])
  end

  def create
    color = Color.new(color_params)
    if color.save
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    color = Color.find(params[:id])
    if color.update(color_params)
      redirect_to admin_colors_path
    end
  end

  def destroy
    color = Color.find(params[:id])
    if color.destroy
      redirect_back(fallback_location: root_path)
    end
  end

  private

     def color_params
       params.require(:color).permit(:name)
     end
end
