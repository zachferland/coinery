class AddOrderIdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :order_id, :string
  end
end
