class Public::CommentsController < ApplicationController
  def create
    @sell_item = SellItem.find(params[:sell_item_id])
    if @comment = Comment.create(comment_params)
      @comments = @sell_item.comments.order(created_at: :desc)
      render :index
    else
      flash.now[:danger] = "値を入力してください。"
      render 'public/sell_items/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @sell_item = SellItem.find(params[:sell_item_id])
    if @comment.destroy
      @comments = @sell_item.comments.order(created_at: :desc)
      render :index
    else
      render 'public/sell_items/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :sell_item_id, :user_id)
  end
end
