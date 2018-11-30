class CreateGiftcodes < ActiveRecord::Migration[5.2]
  def change
    create_table :giftcodes do |t|
      t.string :code
      t.integer :value

      t.timestamps
    end
  end
end
