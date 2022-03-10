class Admins::CustomersController < Admins::BaseController
  before_action :set_customer, only: [:edit, :update, :destroy]
  def index
    @pagy, @customers = pagy(Customer.all.order(id: :asc), items: 10, link_extra: 'data-remote="true"')
    if params[:search]
      @pagy, @customers = pagy(Search.new(Customer.all).search(params[:search]), items: 10, link_extra: 'data-remote="true"')
    elsif params[:sort]
      @pagy, @customers = pagy(Sort.new(Customer.all).sort(params[:sort]), items: 10, link_extra: 'data-remote="true"')
      @class_sort = params[:sort]
      respond_to do |format|
        format.html { redirect_to admins_customers_path }
        format.js
      end
    elsif params[:sort_contra]
      @pagy, @customers = pagy(Sort.new(Customer.all).sort_contra(params[:sort_contra]), items: 10, link_extra: 'data-remote="true"')
      @class_sort_contra = params[:sort_contra]
      respond_to do |format|
        format.html { redirect_to admins_customers_path }
        format.js
      end
    end
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash[:success] = 'Customer created successful'
      redirect_to admins_customers_path
    else
      flash[:error] = 'Customer created failed'
      render :new
    end
  end

  def edit
    if params[:information]
      @information = true
      respond_to do |format|
        format.html { redirect_to edit_admins_customer_path }
        format.js
      end
    elsif params[:payment]
      @payment = true
      respond_to do |format|
        format.html { redirect_to edit_admins_customer_path }
        format.js
      end
    end
  end

  def update
    if @customer.update(customer_params)
      flash[:success] = 'Customer updated successful'
      redirect_to admins_customers_path
    else
      flash[:error] = 'Customer updated failed'
      render :edit
    end
  end

  def destroy
    if @customer.destroy
      flash[:sucess] = 'Customer destroyed successful'
      redirect_to admins_customers_path
    else
      flash[:error] = 'Customer destroyed failed'
      redirect_to admins_customers_path
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:username, :realname, :email, :address, :phone, :dob, :zipcode, :country, :status)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end