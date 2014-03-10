Coinery::Application.routes.draw do

  # Auth ##########################################
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', :to => 'sessions#destroy'

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
  #  update a product
  put "products/:id" => 'products#update'
  # returns a single product, no auth needed
  get "products/:id" => 'products#show'
  #  returns all products, no auth needed
  get "products-all" => 'products#all'
  # delete a user's product
  delete "products/:id" => 'products#destroy'

  # Transaction Endpoints ##########################################
  # returns all transactions (sales) of a user
  get "transactions" => 'transactions#user_all'
  #returns transactions of a users product
  get "products/:id/transactions" => 'transactions#product_all'
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




  # resources :users, except: [:new, :edit]
  # resources :transactions, except: [:new, :edit]
  # resources :products, except: [:new, :edit]
  # resources :assets, except: [:new, :edit]
  # resources :customers, except: [:new, :edit]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
