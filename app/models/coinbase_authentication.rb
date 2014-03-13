class CoinbaseAuthentication < ActiveRecord::Base
	belongs_to :user

	def self.refresh
		@users = User.all

		for @user in @users
			# get users coinbase authentication
			@auth = @user.coinbase_authentications.last

			# return @auth

			@client = OAuth2::Client.new(ENV['COINBASE_CLIENT_ID'], ENV['COINBASE_CLIENT_SECRET'], site: 'https://coinbase.com')

			expires_in = @auth.expires_at.to_i - Time.now.to_i 
			# return @client
			token = OAuth2::AccessToken.new(@client, @auth.access_token, opts = {:refresh_token => @auth.refresh_token, :expires_at => @auth.expires_at, :expires_in => expires_in})
			

			# @token_new = @token.refresh!

			# https://coinbase.com/oauth/token
			 # @response = @token.post('/oauth/token', 
    #                             :params => { grant_type: "refresh_token",
    #                             			 refresh_token: @auth.refresh_token,
    #                             			 client_id: ENV['COINBASE_CLIENT_ID'],
    #                             			 client_secret: ENV['COINBASE_CLIENT_SECRET'],
    #                             			 redirect_uri: ENV['ROOT'] + "api/coinbase/auth/callback" })

			# string_request = 'https://coinbase.com/oauth/token?grant_type=refresh_token&refresh_token=' + @auth.refresh_token + '&client_id=' + ENV['COINBASE_CLIENT_ID'] + '&client_secret=' + ENV['COINBASE_CLIENT_SECRET'] + '&redirect_uri=' + 'http%3A%2F%2Flocalhost%3A3000%2Fapi%2Fcoinbase%2Fauth%2Fcallback'
			# @response = @token.post(string_request)

			# string_request = 'https://coinbase.com/oauth/token?grant_type=refresh_token&code=' + @auth.refresh_token + '&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fapi%2Fcoinbase%2Fauth%2Fcallback&client_id=' + ENV['COINBASE_CLIENT_ID'] + '&client_secret=' + ENV['COINBASE_CLIENT_SECRET']

			# string_request = 'https://coinbase.com/oauth/token?grant_type=refresh_token&refresh_token=' + @auth.refresh_token + '&client_id=' + ENV['COINBASE_CLIENT_ID'] + '&client_secret=' + ENV['COINBASE_CLIENT_SECRET']
			# @response = @token.post(string_request)

			# @response = HTTParty.post(string_request)

      		# @body = @response.parsed



      		# @response = token.post('/oauth/token', 
        #                         :params => { grant_type: 'refresh_token', 
        #                                                refresh_token: @auth.refresh_token, 
        #                                                redirect_uri: "http%3A%2F%2Flocalhost%3A3000%2Fapi%2Fcoinbase%2Fauth%2Fcallback",  
        #                                                client_id:  ENV['COINBASE_CLIENT_ID']})



			return @response

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
