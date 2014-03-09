json.array!(@users) do |user|
  json.extract! user, :id, :email, :username, :full_name, :bio, :twitter_handle
  json.url user_url(user, format: :json)
end
