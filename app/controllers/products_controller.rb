class ProductsController < ApplicationController
  before_filter :permission, only: [:create, :destroy, :update]


  # GET /products
  # GET /products.json
  def all
    @products = Product.all

    render json: @products
  end

  def user_all 
    @user = current_user
    @products = @user.products

    render json: @products
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    render json: @product
  end

  # POST /products
  # POST /products.json

  def create
    @user = current_user
    @product = @user.products.new(product_params)

    if @product.save
      render json: @product, status: :created  #, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @user = current_user
    @product = @user.products.find(params[:id])

    if @product.update(params[:product])
      head :no_content
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
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
