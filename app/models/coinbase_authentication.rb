class CoinbaseAuthentication < ActiveRecord::Base
	belongs_to :user

	def user 
		User.find(self.user_id)
	end 

	def valid_token?
		expires_at.to_i > Time.now.to_i
	end

	def refresh
		# if !valid? 
		# force refresh each product creation for now, a bit janky
			post_string = 'https://coinbase.com/oauth/token?grant_type=refresh_token&code=' + coinbase_user_id + '&refresh_token=' + refresh_token
			response = HTTParty.post(post_string).parsed_response
			update(access_token: response['access_token'], refresh_token: response['refresh_token'], expires_at: response['expires_at'])
		# end 
	end 
end
