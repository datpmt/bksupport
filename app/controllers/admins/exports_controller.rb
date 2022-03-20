class Admins::ExportsController < Admins::BaseController
  def customers_export
  	csv = Export.new(Customer.all, Customer::CSV_CUSTOMERS)
    respond_to do |format|
      format.csv { send_data csv.perform,
        filename: "Customers_#{Time.now.strftime("%d/%m/%Y")}.csv" }
    end
  end

  def admins_export
    csv = Export.new(Administrator.all, Administrator::CSV_ADMINS)
    respond_to do |format|
      format.csv { send_data csv.perform,
        filename: "Administrators_#{Time.now.strftime("%d/%m/%Y")}.csv" }
    end
  end

  def orders_export
    csv = Export.new(Order.all, Order::CSV_ORDERS)
    respond_to do |format|
      format.csv { send_data csv.perform,
        filename: "Orders__#{Time.now.strftime("%d/%m/%Y")}.csv" }
    end
  end


  private
  def order_list
    Order.includes(:payment, :cart, :address).references(:payment, :cart, :address)
  end
end
