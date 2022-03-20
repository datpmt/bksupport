class OrderMailer < ApplicationMailer
  def order_email
    @order    = params[:order]
    @customer = params[:customer]
    mail(to: @customer.email, subject: "Bạn có một đơn đặt hàng mới!")
  end

  def order_status
    @order    = params[:order]
    @customer = params[:customer]
    if @order.status == 'shipping'
      mail(to: @customer.email, subject: "Đơn hàng của bạn đang được vận chuyển!")
    elsif @order.status == 'completed'
      mail(to: @customer.email, subject: "Đơn hàng của bạn đã giao thành công!")
    end
  end
end
