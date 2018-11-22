class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.integer :account, default: 1000000
      t.references :user
      
      t.timestamps
    end
  end
end
