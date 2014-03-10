module Api
  class TransactionsController < ApplicationController
    before_filter :permission, only: [:index, :show]
  
    def user_all
      @user = current_user
      @transactions = @user.transactions
  
      render json: @transactions
    end
  
    def product_all
      @user = current_user
      @product = @user.products.find(params[:id])
      @transactions = @product.transactions
  
      render json: @transactions
    end
  
    def show
      @user = current_user
      @transaction = Transaction.find(params[:id])
  
      render json: @transaction
    end
  
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
