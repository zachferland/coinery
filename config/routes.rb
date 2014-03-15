Coinery::Application.routes.draw do

  get "coinbase_authentications/url"
  apipie

  # Auth ##########################################
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', :to => 'sessions#destroy'

  # move this, add a application controller to the api and then inheret that from an 
  # application controller outside the api module
  get 'api/coinbase/price' => "application#usd_to_btc"

  # API ENDPOINTS
  namespace :api do
    # User Endpoints ##########################################
    # return current user
    get "user" => 'users#show'
    #  update current user
    put "user" => 'users#update'
  
  
  
    # Product Endpoints ##########################################
    #  create a product for the current user
    post "products" => 'products#create'
    # returns all products of a current user
    get "products" => 'products#user_all'
    #  returns all products, no auth needed
    get "products/all" => 'products#all'
    #  update a product
    put "products/:id" => 'products#update'
    # returns a single product, no auth needed
    get "products/:id" => 'products#show'
    # delete a user's product
    delete "products/:id" => 'products#destroy'
    # returns assets for a give product (no auth)
    get "products/:id/assets" => 'products#product_assets'
     # returns customers of a  users product
    get "products/:id/customers" => 'products#customers'
    #returns transactions of a users product
    get "products/:id/transactions" => 'products#product_transactions'
    # publish a product 
    put "/products/:id/publish" => 'products#publish'
  
  
    # Transaction Endpoints ##########################################
    # returns all transactions (sales) of a user
    get "transactions" => 'transactions#user_all'
    # show a individual transaction
    get "transactions/:id" => 'transactions#show'
    # create a transaction
    post "transactions" => 'transactions#create'
    # create a transaction
    post "transactions/callback" => 'transactions#order_callback'
  
  
  
     # Customer Endpoints ##########################################
     # returns all customers of a users products
    get "customers" => 'customers#user_all'
    # create a customer
    post "customers" => 'customers#create'
  
  
  
    # Asset Endpoints ##########################################
    # create an asset for a product (auth)
    post "products/:id/assets" => 'assets#create'
    # returns a single asset 
    get "assets/:id" => 'assets#show'
    # delets asset of user
    delete "assets/:id" => 'assets#destroy'

    # Customer Endpoints ##########################################
    get 'coinbase/auth/url' => 'coinbase_authentications#url'
    get 'coinbase/auth/callback' => 'coinbase_authentications#callback'
    get 'coinbase/auth' => 'coinbase_authentications#create'


  end

end
