class ShoppingController < ApplicationController
  include Pagy::Backend
  layout 'application'
  def index
    @pagy, @products = pagy(Product.all.order(id: :asc), items: 9, link_extra: 'data-remote="true"')
    if params[:search]
      @pagy, @products = pagy(Product.all.where('name ILIKE ?', "%#{params[:search]}%"))
    elsif params[:city]
      @pagy, @products = pagy(Product.all.where(city_id: params[:city]), items: 9, link_extra: 'data-remote="true"')
    elsif params[:region]
      cities = City.all.where(region_id: params[:region])
      @pagy, @products = pagy(Product.all.where(city_id: cities), items: 9, link_extra: 'data-remote="true"')
    elsif params[:sort]
      @pagy, @products = pagy(Sort.new(Product.all).sort(params[:sort]), items: 9, link_extra: 'data-remote="true"')
      @class_sort = params[:sort]
      respond_to do |format|
        format.js
      end
    elsif params[:sort_contra]
      @pagy, @products = pagy(Sort.new(Product.all).sort_contra(params[:sort_contra]), items: 9, link_extra: 'data-remote="true"')
      @class_sort_contra = params[:sort_contra]
      respond_to do |format|
        format.js
      end
    end
  end

  def cart
    session[:cart] ||= []
    new_cart = [id: params[:item_id], quantity: params[:quantity]]
    if session[:cart].empty?
      tmp = session[:cart].push(new_cart)
      session[:cart]= tmp
    else
      # check trung
      session[:cart].each do |cart|
        if cart[0]["id"] == params[:item_id]
          return cart[0]["quantity"] = params[:quantity].to_i + cart[0]["quantity"].to_i
        end
      end
      tmp = session[:cart].push(new_cart)
      session[:cart]= tmp
    end
  end

  def edit_cart
    if params[:action_edit]=='minus'
      session[:cart].each do |cart|
        if cart[0]["id"] == params[:item_id]
          cart[0]["quantity"] = cart[0]["quantity"].to_i - 1
        end
      end
    elsif params[:action_edit]=='plus'
      session[:cart].each do |cart|
        if cart[0]["id"] == params[:item_id]
          cart[0]["quantity"] = cart[0]["quantity"].to_i + 1
        end
      end
    else
      session[:cart].each do |cart|
        if cart[0]["id"] == params[:item_id]
          cart[0]["quantity"] = 0
        end
      end
    end
    respond_to do |format|
      format.js
    end
  end
end
