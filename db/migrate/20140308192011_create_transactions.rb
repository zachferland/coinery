class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :product_id
      t.integer :user_id
      t.integer :customer_id
      t.float :usd
      t.float :btc
      t.string :status

      t.timestamps
    end
  end
end
