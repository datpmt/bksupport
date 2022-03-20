class Order < ApplicationRecord
  belongs_to :customer
  enum status: { pending: 'pending', shipping: 'shipping', completed: 'completed' }
  CSV_ORDERS = %w(customer_id detail total payment_method status created_at).freeze
end
