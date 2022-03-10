class Product < ApplicationRecord
  belongs_to :city
  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :city_id, presence: true
  validates :short_des, presence: true
  validates :sale_off, presence: true
  validates :description, presence: true
end
