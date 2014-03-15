class AddCoinbaseUserIdToCoinbaseAuthentications < ActiveRecord::Migration
  def change
    add_column :coinbase_authentications, :coinbase_user_id, :string
  end
end
