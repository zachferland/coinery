class TransactionsController < ApplicationController
  before_filter :permission, only: [:index, :show]
  # GET /transactions
  # GET /transactions.json

  # Return all transactions of a user
  def user_all
    @user = current_user
    @transactions = @user.transactions

    render json: @transactions
  end

  #return all transactions of a product
   def product_all
    @user = current_user
    @product = @user.products.find(params[:id])
    @transactions = @product.transactions

    render json: @transactions
  end

  # GET /transactions/1
  # GET /transactions/1.json

  # Return specified transaction of a user
  def show
    @user = current_user
    @transaction = Transaction.find(params[:id])

    render json: @transaction
  end

  # POST /transactions
  # POST /transactions.json

  # create transaction from callback from coinbase
  # will have to format return from coinbase properly 
  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      render json: @transaction, status: :created #, location: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  # def update
  #   @transaction = Transaction.find(params[:id])

  #   if @transaction.update(params[:transaction])
  #     head :no_content
  #   else
  #     render json: @transaction.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  # def destroy
  #   @transaction = Transaction.find(params[:id])
  #   @transaction.destroy

  #   head :no_content
  # end

  def transaction_params
    params.require(:transaction).permit(:product_id, :customer_id, :usd, :btc, :status)
  end
end
