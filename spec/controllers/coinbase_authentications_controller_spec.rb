require 'spec_helper'

describe CoinbaseAuthenticationsController do

  describe "GET 'url'" do
    it "returns http success" do
      get 'url'
      response.should be_success
    end
  end

end
