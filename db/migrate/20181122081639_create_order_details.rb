class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.integer :price
      t.references :course
      t.references :order

      t.timestamps
    end
  end
end
