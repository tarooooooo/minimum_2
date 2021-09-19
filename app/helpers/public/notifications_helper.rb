module Public::NotificationsHelper
  def notification_form(notification)
    #通知を送ってきたユーザーを取得
    @visitor = notification.visitor
    #コメントの内容を通知に表示する
    @comment = nil
    @visitor_comment = notification.comment_id
    # notification.actionがfollowかlikeかcommentかで処理を変える
    case notification.action
    when 'follow'
      #aタグで通知を作成したユーザーshowのリンクを作成
      tag.a(notification.visitor.name) + 'があなたをフォローしました'
    when 'like'
      "#{User.find_by(id: notification.visitor_id).nickname}があなたの投稿にいいねしました"
    when 'comment' then
      #コメントの内容と投稿のタイトルを取得
      @comment = Comment.find_by(id: @visitor_comment)
      @comment_text =@comment.text
      @sell_item_name =@comment.sell_item.name
      "#{User.find_by(id: notification.visitor_id).nickname}が,#{@sell_item_name}にコメントしました"
    end
  end
end
