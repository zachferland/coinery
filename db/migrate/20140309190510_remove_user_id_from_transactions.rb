class RemoveUserIdFromTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :user_id, :integer
  end
end
