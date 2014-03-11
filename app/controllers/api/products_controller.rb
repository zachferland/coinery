module Api
  class ProductsController < ApplicationController
    before_filter :permission, only: [:create, :destroy, :update]
    
    def_param_group :product do 
      param :title, String
      param :description, String
      param :price, String
      # asset
    end
    
    api :GET, '/products/all', "Get all products"
    def all
      @products = Product.all
  
      render json: @products
    end

    api :GET, '/products/:id/assets', "Get assets of a product"
    def product_assets
      @product = Product.find(params[:id])
      @assets = @product.assets
  
      render json: @assets
    end

    api :GET, '/products/:id/customers', "Get all product's customers"
    def product_customers
      @user = current_user
      @product = @user.products.find(params[:id])
      @customers = @products.customers
  
      render json: @customers
    end

    api :GET, '/products/:id/transactions', "Get all product's transactions(sales)"
    def product_transactions
      @user = current_user
      @product = @user.products.find(params[:id])
      @transactions = @product.transactions
  
      render json: @transactions
    end
    
    api :GET, '/products', "Get all user's products"
    def user_all 
      @user = current_user
      @products = @user.products
  
      render json: @products
    end
    
    api :GET, '/products/:id', "Show a individual product"
    def show
      @product = Product.find(params[:id])
  
      render json: @product
    end
    
    api :POST, '/products', "Create a product"
    param_group :product
    def create
      @user = current_user
      @product = @user.products.new(product_params)
  
      if @product.save
        render json: @product, status: :created  #, location: @product
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end
    
    api :PUT, '/products/:id', "Update a product"
    param_group :product
    def update
      @user = current_user
      @product = @user.products.find(params[:id])
  
      if @product.update(params[:product])
        head :no_content
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end
    
    api :DELETE, '/products/:id', "Delete a product"
    def destroy
      @user = current_user
      @product = @user.products.find(params[:id])
      @product.destroy
  
      head :no_content
    end
  
    def product_params
      params.require(:product).permit(:title, :description, :price, :image) #user_id?
    end
  
  end
end

