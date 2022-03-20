class Admins::OrdersController < Admins::BaseController
  before_action :set_order, only: [:edit, :update, :destroy]
  def index
    @pagy, @orders = pagy(Order.all.order(id: :asc), items: 10, link_extra: 'data-remote="true"')
    if params[:search]
      @pagy, @orders = pagy(Search.new(Order.all).search(params[:search]), items: 10, link_extra: 'data-remote="true"')
    elsif params[:sort]
      @pagy, @orders = pagy(Sort.new(Order.all).sort(params[:sort]), items: 10, link_extra: 'data-remote="true"')
      @class_sort = params[:sort]
      respond_to do |format|
        format.html { redirect_to admins_orders_path }
        format.js
      end
    elsif params[:sort_contra]
      @pagy, @orders = pagy(Sort.new(Order.all).sort_contra(params[:sort_contra]), items: 10, link_extra: 'data-remote="true"')
      @class_sort_contra = params[:sort_contra]
      respond_to do |format|
        format.html { redirect_to admins_orders_path }
        format.js
      end
    end
  end

  def new
    @order = Order.new
  end


  def edit
    if params[:information]
      @information = true
      respond_to do |format|
        format.html { redirect_to edit_admins_order_path }
        format.js
      end
    elsif params[:payment]
      @payment = true
      respond_to do |format|
        format.html { redirect_to edit_admins_order_path }
        format.js
      end
    end
  end

  def update
    if @order.update(order_params)
      OrderMailer.with(order: @order, customer: current_customer).order_status.deliver_later
      flash[:success] = 'Order updated successful!'
      redirect_to admins_orders_path
    else
      flash[:error] = 'Order updated failed!'
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end