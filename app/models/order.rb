class Order < ApplicationRecord
  belongs_to :customer
  enum status: { pending: 'pending', shipping: 'shipping', completed: 'completed' }
end
