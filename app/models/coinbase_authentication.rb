class CoinbaseAuthentication < ActiveRecord::Base
	belongs_to :user

	def self.refresh
		@users = User.all

		for @user in @users
			# get users coinbase authentication
			@auth = @user.coinbase_authentications.first

			@client = OAuth2::Client.new(ENV['COINBASE_CLIENT_ID'], ENV['COINBASE_CLIENT_SECRET'], site: 'https://coinbase.com')
			@token = OAuth2::AccessToken.new(@client, @user_token, opts = {:refresh_token => @refresh})

			return @token.client

			# @auth.update(access_token: @token.token, refresh_token: @token.refresh_token, expires_at: @token.expires_at)



			# finish this later

			# create token object
			# determine if it has less then 31 minutes left, then refresh
			# refresh token object
			# update auth 
			# save auth
			# 

		end

	end 


end
