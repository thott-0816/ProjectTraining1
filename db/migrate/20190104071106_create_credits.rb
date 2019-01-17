class CreateCredits < ActiveRecord::Migration[5.2]
  def change
    create_table :credits do |t|
      t.references :e_wallet, foreign_key: true, default: nil
      t.string :number
      t.string :bank
      t.string :card_type
      t.integer :balances, default: 10000000
      t.datetime :expiration_date
      t.string :name
      t.string :gender
      t.date :date_of_birth
      t.string :address
      t.string :phone
      t.string :email
      t.string :employed_by
      
      t.timestamps
    end
  end
end
