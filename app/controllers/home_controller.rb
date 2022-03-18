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
end
