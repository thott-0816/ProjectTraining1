class CreateCredits < ActiveRecord::Migration[5.2]
  def change
    create_table :credits do |t|
      t.references :e_wallet, foreign_key: true
      t.string :number
      t.string :bank
      t.integer :card_type
      t.integer :balances, default: 10000000
      t.datetime :expiration_date
      t.string :name
      t.integer :gender
      t.date :date_of_birth
      t.string :address
      t.string :phone
      t.string :email
      t.string :employed_by
      t.boolean :approved, default: false
      t.boolean :connected, default: false
      
      t.timestamps
    end
  end
end
