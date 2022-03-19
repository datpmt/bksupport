class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :total
      t.text :detail
      t.string :payment_method
      t.string :city
      t.string :district
      t.string :address

      t.timestamps
    end
  end
end
