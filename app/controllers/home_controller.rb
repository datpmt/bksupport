class HomeController < ActionController::Base
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
  end

  def cart
  end

  def checkout
    authenticate_customer!
    if session[:cart].nil? || session[:total] == 30000
      redirect_to cart_path
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
      Order.create(
        customer_id:    current_customer.id,
        total:          params[:total],
        detail:         params[:detail],
        payment_method: params[:payment_method],
        city:           params[:city],
        district:       params[:district],
        address:        params[:address]
      )
      flash[:success] = "Đặt hàng thành công. Vui lòng kiểm tra email để xem thông tin đơn hàng!"
      redirect_to checkout_path
    end
  end
end
