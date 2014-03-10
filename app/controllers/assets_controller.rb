class AssetsController < ApplicationController
  before_filter :permission, only: [:create, :destroy]

  has_attached_file :asset
  # asset type validation and other validation possible here


  # GET /assets
  # GET /assets.json
  def product_assets
    @product = Product.find(params[:id])
    @assets = @product.assets

    render json: @assets
  end

  # GET /assets/1
  # GET /assets/1.json
  def show
    @asset = Asset.find(params[:id])

    render json: @asset
  end

  # POST /assets
  # POST /assets.json
  def create
    @user = current_user
    @product = @user.products.find(params[:id])
    @asset = @product.assets.new(params[:asset])

    if @asset.save
      render json: @asset, status: :created # ,location: @asset
    else
      render json: @asset.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /assets/1
  # PATCH/PUT /assets/1.json
  # def update
  #   @asset = Asset.find(params[:id])

  #   if @asset.update(params[:asset])
  #     head :no_content
  #   else
  #     render json: @asset.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
    @user = current_user
    @asset = @user.assets.find(params[:id])
    @asset.destroy

    head :no_content
  end

  def asset_params
    params.require(:asset).permit(:asset, :product_id)
  end
end
