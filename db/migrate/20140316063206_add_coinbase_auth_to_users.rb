class AddCoinbaseAuthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :coinbase_auth, :boolean
  end
end
