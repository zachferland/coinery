Coinery::Application.routes.draw do

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', :to => 'sessions#destroy'


  # user endpoints
  # returns user json model
  get "user" => 'users#show'
  put "user" => 'user#update'
  # user/products -> products of current user
  # user/products/:id -> single product of current user
  # may not user customers
  # user/customer -> all customers of current users products
  # user/customer/:id -> particular customer of user


  # product endpoints
  post "products" => 'product#create'
  get "products" => 'product#user_all'
  put "products/:id" => 'product#update'
  get "products/:id" => 'product#show'
  get "products/all" => 'product#all'







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
