class NotificationMailer < ApplicationMailer
  default from: "ryutaromaeda83@gmail.com"
  def send_mail(buyer, sell_item)
    @user = buyer
    @sell_item = sell_item
    mail(to: buyer.email, subject: '購入品詳細')
  end
  
  def seller_send_mail(seller, sell_item)
    @seller = seller
    @sell_item = sell_item
    mail(to: seller.email, subject: 'あなたの商品が購入されました！')
  end
end
