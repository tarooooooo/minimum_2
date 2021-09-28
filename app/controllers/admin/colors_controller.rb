class Admin::ColorsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @color = Color.new
    @colors = Color.all
  end

  def edit
    @color = Color.find(params[:id])
  end

  def create
    @color = Color.new(color_params)
    if @color.save
      flash[:success] = "登録が完了しました。"
      redirect_back(fallback_location: root_path)
    else
      @colors = Color.all
      flash.now[:danger] = "登録ができませんでした。"
      render 'index'
    end
  end

  def update
    @color = Color.find(params[:id])
    if @color.update(color_params)
      flash[:success] = "登録が完了しました。"
      redirect_to admin_colors_path
    else
      flash.now[:danger] = "編集ができませんでした。"
      render 'edit'
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
       params.require(:color).permit(:name,:color_code)
     end
end
