class NotificationMailer < ApplicationMailer
  default from: "ryutaromaeda83@gmail.com", subject: "購入ありがとうございます。"
  def send_mail(user, sell_item)
    @user = user
    @sell_item = sell_item
    mail to: user.email
  end
end
