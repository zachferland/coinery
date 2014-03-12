class AddExpiredAtFromCoinbaseAuthentications < ActiveRecord::Migration
  def change
    add_column :coinbase_authentications, :expires_at, :string
  end
end
