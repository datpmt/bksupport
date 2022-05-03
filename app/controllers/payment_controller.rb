class PaymentController < ApplicationController
  layout 'customer'
  def index
  end

  def create
    order = Order.find(params[:order_id])
    if order.status == 'pending'
      description = "payment for order: #{order.id}"
      customer =  Stripe::Customer.create email: current_customer.email, card: params[:stripe_token]
      stripe_response = Stripe::Charge.create(customer: customer.id,
                                                amount: ((order.total.to_i)/250).to_i,
                                                description: description,
                                                currency: 'usd')
      if stripe_response.status == "succeeded"
        order.update(status: 'paid')
        OrderMailer.with(order: order, customer: current_customer).order_email.deliver_later
        flash[:success] = "Đặt hàng thành công. Vui lòng kiểm tra email để xem thông tin đơn hàng!"
        render json: {
          success: true
        }
      end
    else
      flash[:error] = 'Order has been exist!'
      redirect_to payment_path(order_id: params[:order_id])
    end
  end
end