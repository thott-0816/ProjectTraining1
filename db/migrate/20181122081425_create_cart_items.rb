class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.references :user
      t.references :course

      t.timestamps
    end
  end
end
