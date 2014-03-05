class ChargesController < ActionController::Base

  def new
  end

  def create
  end

  protected

  def set_coinbase_client
    @client = Coinbase::Client.new(ENV['COINBASE_API_KEY'], ENV['COINBASE_API_SECRET'])
  end
end
