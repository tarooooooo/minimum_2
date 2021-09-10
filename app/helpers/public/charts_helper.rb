module Public::ChartsHelper
  def month_ago(number)
    now = Time.current
    now.ago(number.month).month
  end
end
