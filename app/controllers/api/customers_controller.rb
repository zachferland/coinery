module Api
  class CustomersController < ApplicationController
     before_filter :permission, only: [:user_all, :product_all]
  
    def user_all
      @user = current_user
      @customers = @user.customers
  
      render json: @customers
    end
  
    def product_all
      @user = current_user
      @product = @user.products.find(params[:id])
      @customers = @products.customers
  
      render json: @customers
    end
  
    def create
      @customer = Customer.new(customer_params)
  
      if @customer.save
        render json: @customer, status: :created #, location: @customer
      else
        render json: @customer.errors, status: :unprocessable_entity
      end
    end
  
    def customer_params
      params.require(:customer).permit(:email)
    end
  end
end
