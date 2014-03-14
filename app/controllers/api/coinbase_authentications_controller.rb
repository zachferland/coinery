module Api
	class CoinbaseAuthenticationsController < ApplicationController

  		def url
  			@client = coinbase_client
  			@url = @client.auth_code.authorize_url(redirect_uri: ENV['ROOT'] + "api/coinbase/auth/callback")

  			render json: @url
  		end

 
  		def callback 
  			code = params[:code]
  			client = coinbase_client
  			token = client.auth_code.get_token(code, redirect_uri: ENV['ROOT'] + "api/coinbase/auth/callback")

        # get coinbase user id, make reqest to user
        response = token.get('api/v1/users').parsed
        coinbase_user_id = response['users'][0]['user']['id']

  			user = current_user
      	auth = user.coinbase_authentications.new(access_token: token.token, refresh_token: token.refresh_token, expires_at: token.expires_at, coinbase_user_id: coinbase_user_id)

 			if auth.save
      			# created, where shoult id redirect is, any params need to be passed
        		redirect_to ENV['ROOT'] + "/#/product"
        		# render json: coinbase_user_id
     		else
        		redirect_to ENV['ROOT']
        	end
  		end 



	end
end