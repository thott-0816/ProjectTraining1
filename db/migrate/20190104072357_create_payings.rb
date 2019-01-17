class CreatePayings < ActiveRecord::Migration[5.2]
  def change
    create_table :payings do |t|
      t.references :e_wallet, foreign_key: true
      t.integer :amount
      t.integer :status
      t.string :uname
      t.string :uemail
      t.integer :uid

      t.timestamps
    end
  end
end
