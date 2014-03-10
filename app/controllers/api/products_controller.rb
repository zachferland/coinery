module Api
  class ProductsController < ApplicationController
    before_filter :permission, only: [:create, :destroy, :update]
  
    def all
      @products = Product.all
  
      render json: @products
    end
  
    def user_all 
      @user = current_user
      @products = @user.products
  
      render json: @products
    end
  
    def show
      @product = Product.find(params[:id])
  
      render json: @product
    end
  
    def create
      @user = current_user
      @product = @user.products.new(product_params)
  
      if @product.save
        render json: @product, status: :created  #, location: @product
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end
  
    def update
      @user = current_user
      @product = @user.products.find(params[:id])
  
      if @product.update(params[:product])
        head :no_content
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end
  
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

