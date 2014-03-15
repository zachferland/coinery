module Api
  class TransactionsController < ApplicationController
    before_filter :permission, only: [:index, :show]

    def_param_group :transaction do 
      param :product_id, Integer
      param :customer_id, Integer
      param :usd, Float
      param :btc, Float
      # param :status, String
    end

    # add order id

    # does this need a status attribute?
    
    api :GET, '/transactions', "Get all transactions(sales)"
    def user_all
      @user = current_user
      @transactions = @user.transactions
  
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






    api :POST, '/transactions/callback', "Create a transaction from coinbase callback"
    def order_callback
      # not sure if actually  works yet

      @response = response.parsed

      # should it be formated as @response['order']['custom']
      # check response status if failed throw error
      product_id = @response['custom']
      order_id = @response['id']
      user_id = @product.user_id 
      usd = @response['total_btc']['cents']  #cents
      btc = @response['total_native']['cents'] #cents
      @product = Product.find(product_id) 


      # does a customer need to be create here or just forget it, usd and btc in cents 
      @transaction = Transaction.new(product_id: product_id, usd: usd, btc: btc, order_id: order_id)
      
      @transaction.save
      # how do i handle errors
      # if @transaction.save
      #   render json: @transaction, status: :created #, location: @transaction
      # else
      #   render json: @transaction.errors, status: :unprocessable_entity
      # end
    end





  
    def transaction_params
      params.permit(:product_id, :customer_id, :usd, :btc, :order_id, :status)
    end
  end
end
