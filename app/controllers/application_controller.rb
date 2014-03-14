class ApplicationController < ActionController::API
	# protect_from_forgery

   # move this, add a application controller to the api and then inheret that from an 
  # application controller outside the api module
  def usd_to_btc
    token = coinbase_token
    @response = token.get('/api/v1/currencies/exchange_rates')

    body = @response.parsed
    @usd_to_btc = body['usd_to_btc']

    render json: @usd_to_btc
  end 
  
	protected

  	def current_user
    	@current_user ||= User.find_by(id: session[:user_id])
  	end

 	  def signed_in?
    	!!current_user
  	end

  	def current_user=(user)
    	@current_user = user
    	session[:user_id] = user.nil? ? user : user.id
  	end

  	def permission
  		head :unauthorized unless signed_in?
  	end

    def coinbase_client 
        @client = OAuth2::Client.new(ENV['COINBASE_CLIENT_ID'], ENV['COINBASE_CLIENT_SECRET'], site: 'https://coinbase.com')
    end

    def coinbase_token
      user = current_user # what if user dow not exist
      auth = user.coinbase_authentications.last
      user_token = auth.access_token
      refresh = auth.refresh_token
      client = coinbase_client

      @token = OAuth2::AccessToken.new(client, user_token, opts = {:refresh_token => refresh})
    end

end
