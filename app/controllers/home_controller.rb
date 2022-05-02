class HomeController < ApplicationController
  include Pagy::Backend
  layout 'application'
  def index
  end

  def term
  end

  def about_us
  end

  def contact
  end

  def product_detail
  end

  def my_acc
    authenticate_customer!
    @pagy, @orders = pagy(Order.all.where(customer_id: current_customer), items: 5, link_extra: 'data-remote="true"')
  end

  def information
    if current_customer.valid_password?(params[:password])
      current_customer.update(
        real_name: params[:name],
        phone:      params[:phone],
        city:       params[:city],
        district:   params[:district],
        address:    params[:address],
      )
      flash[:success] = "Cập nhật thành công!"
    else
      flash[:error] = "Mật khẩu không chính xác! Vui lòng thử lại!"
    end
    redirect_to my_acc_path
  end

  def cart
  end

  def checkout
    authenticate_customer!
    if session[:cart].nil? || session[:total] == 30000
      redirect_to cart_path
    else
      if params[:success]
        session.delete(:cart)
      end
    end
  end

  def order
    if params[:city].empty? || params[:real_name].empty? || params[:phone].empty? || params[:district].empty? || params[:address].empty?
      flash[:error] = "Hãy điền đẩy đủ thông tin trước khi đặt hàng!"
      redirect_to checkout_path
    else
      current_customer.update(
        real_name:      params[:real_name],
        phone:          params[:phone],
        city:           params[:city],
        district:       params[:district],
        address:        params[:address]
      )
      @order = Order.create(
        customer_id:    current_customer.id,
        total:          params[:total],
        detail:         params[:detail],
        payment_method: params[:payment_method],
        city:           params[:city],
        district:       params[:district],
        address:        params[:address]
      )
      OrderMailer.with(order: @order, customer: current_customer).order_email.deliver_later
      flash[:success] = "Đặt hàng thành công. Vui lòng kiểm tra email để xem thông tin đơn hàng!"
      redirect_to checkout_path(success: true)
    end
  end

end
