json.array!(@assets) do |asset|
  json.extract! asset, :id, :product_id, :type, :size
  json.url asset_url(asset, format: :json)
end
