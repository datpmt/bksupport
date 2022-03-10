class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :short_des
      t.text :description
      t.string :price
      t.string :quantity
      t.string :sale_off
      t.string :star
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
