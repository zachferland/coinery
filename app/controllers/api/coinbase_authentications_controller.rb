module Api
	class CoinbaseAuthenticationsController < ApplicationController

  		def url
  			@client = coinbase_client
  			@url = @client.auth_code.authorize_url(redirect_uri: ENV['ROOT'] + "api/coinbase/auth/callback?product_id=27", scope: "merchant")

  			render json: @url
  		end

 
  		def callback 
        code = params[:code]
        product_id = params[:product_id]
        client = coinbase_client
        token = client.auth_code.get_token(code, redirect_uri: ENV['ROOT'] + "api/coinbase/auth/callback?product_id=" + product_id)

        # get coinbase user id, make reqest to user
        response = token.get('api/v1/users').parsed
        coinbase_user_id = response['users'][0]['user']['id']

        # what if no current user
        @auth = current_user.coinbase_authentications.new(access_token: token.token, refresh_token: token.refresh_token, expires_at: token.expires_at, coinbase_user_id: coinbase_user_id)

        if @auth.save
            # update user model when an auth is added
             @auth.user.update(coinbase_auth: true)
            # created, where shoult id redirect is, any params need to be passed
            redirect_to ENV['ROOT'] + "#/products/edit/" + product_id
        else
             redirect_to ENV['ROOT'] + "#/product"
            # fails?
          end
      end 


	end
end


