module Api
  class TransactionsController < ApplicationController
    before_filter :permission, only: [:index, :show]

    def_param_group :transaction do 
      param :product_id, Integer
      param :customer_id, Integer
      param :usd, Float
      param :btc, Float
      param :status, String
    end
    
    api :GET, '/transactions', "Get all transactions(sales)"
    def user_all
      @user = current_user
      @transactions = @user.transactions
  
      render json: @transactions
    end
    
    api :GET, '/products/:id/transactions', "Get all product's transactions(sales)"
    def product_all
      @user = current_user
      @product = @user.products.find(params[:id])
      @transactions = @product.transactions
  
      render json: @transactions
    end
    
    api :GET, '/transactions/:id', "Show an individual transaction"
    def show
      @user = current_user
      @transaction = Transaction.find(params[:id])
  
      render json: @transaction
    end
    
    api :POST, '/transactions', "Create a transaction"
    param_group :transaction
    def create
      @transaction = Transaction.new(transaction_params)
  
      if @transaction.save
        render json: @transaction, status: :created #, location: @transaction
      else
        render json: @transaction.errors, status: :unprocessable_entity
      end
    end
  
    def transaction_params
      params.require(:transaction).permit(:product_id, :customer_id, :usd, :btc, :status)
    end
  end
end
