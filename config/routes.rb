Coinery::Application.routes.draw do

  apipie

  # Auth ##########################################
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', :to => 'sessions#destroy'

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
  
  

    # Transaction Endpoints ##########################################
    # returns all transactions (sales) of a user
    get "transactions" => 'transactions#user_all'
    #returns transactions of a users product
    get "products/:id/transactions" => 'transactions#product_all'
    # show a individual transaction
    get "transactions/:id" => 'transactions#show'
    # create a transaction
    post "transactions" => 'transactions#create'
  
  
  
     # Customer Endpoints ##########################################
     # returns all customers of a users products
    get "customers" => 'customers#user_all'
     # returns customers of a  users product
    get "products/:id/customers" => 'customers#product_all'
    # create a customer
    post "customers" => 'customers#create'
  
  
  
    # Asset Endpoints ##########################################
    # create an asset for a product (auth)
    post "products/:id/assets" => 'assets#create'
    # returns assets for a give product (no auth)
    get "products/:id/assets" => 'assets#product_assets'
    # returns a single asset 
    get "asset/:id" => 'assets#show'
    # delets asset of user
    delete "asset/:id" => 'assets#destroy'
  end

end
