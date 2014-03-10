module Api
  class CustomersController < ApplicationController
     before_filter :permission, only: [:user_all, :product_all]

     def_param_group :customer do 
      param :email, String
    end
  
    api :GET, '/customers', "Get all customers"
    param_group :customer
    def user_all
      @user = current_user
      @customers = @user.customers
  
      render json: @customers
    end
    
    api :GET, '/products/:id/customers', "Get all product's customers"
    param_group :customer
    def product_all
      @user = current_user
      @product = @user.products.find(params[:id])
      @customers = @products.customers
  
      render json: @customers
    end
    
    api :POST, '/customers', "Create a customer"
    param_group :customer
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
