class CustomersController < ApplicationController
   before_filter :permission, only: [:user_all, :product_all]

  # GET /customers
  # GET /customers.json
  def user_all
    @user = current_user
    @customers = @user.customers

    render json: @customers
  end

  # GET /customers/1
  # GET /customers/1.json
  def product_all
    @user = current_user
    @product = @user.products.find(params[:id])
    @customers = @products.customers

    render json: @customers
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(params[:customer])

    if @customer.save
      render json: @customer, status: :created, location: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  # def update
  #   @customer = Customer.find(params[:id])

  #   if @customer.update(params[:customer])
  #     head :no_content
  #   else
  #     render json: @customer.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /customers/1
  # DELETE /customers/1.json
  # def destroy
  #   @customer = Customer.find(params[:id])
  #   @customer.destroy

  #   head :no_content
  # end

  def customer_params
    params.require(:customer).permit(:email)
  end
end
