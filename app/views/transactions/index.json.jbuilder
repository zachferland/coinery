json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :product_id, :user_id, :customer_id, :usd, :btc, :status
  json.url transaction_url(transaction, format: :json)
end
