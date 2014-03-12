class RemoveExpiredAtFromCoinbaseAuthentications < ActiveRecord::Migration
  def change
    remove_column :coinbase_authentications, :expires_at, :datetime
  end
end
