class UserMailer < ApplicationMailer
  default from: "no-reply@jungle.com"

  def order_receipt(order)
    @order = order
    mail(to: @order.email, subject: "Order id: ##{@order.id}")
  end

end
