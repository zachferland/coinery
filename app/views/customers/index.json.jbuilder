json.array!(@customers) do |customer|
  json.extract! customer, :id, :email
  json.url customer_url(customer, format: :json)
end
