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
    data = CSV.generate do |csv|
      csv << Order::CSV_ORDERS
      order_list.each do |order|
        csv << [
          order.id,
          order.address.first_name + " " + order.address.last_name,
          "",
          order.payment&.pay_at&.strftime("%d %b %Y %H:%M%p"),
          order.total,
          order.payment.payment_method,
          order.payment && order.payment == "pending" ? "Waiting for payment" : "Completed"
        ]
      end
    end
    respond_to do |format|
      format.csv { send_data data,
        filename: "Orders_#{Time.now.strftime("%d/%m/%Y")}.csv" }
    end
  end


  private
  def order_list
    Order.includes(:payment, :cart, :address).references(:payment, :cart, :address)
  end
end
