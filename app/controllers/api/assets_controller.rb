module Api
  class AssetsController < ApplicationController
    before_filter :permission, only: [:create, :destroy]
  
    def product_assets
      @product = Product.find(params[:id])
      @assets = @product.assets
  
      render json: @assets
    end
  
    def show
      @asset = Asset.find(params[:id])
  
      render json: @asset
    end
  
    def create
      @user = current_user
      @product = @user.products.find(params[:id])
      @asset = @product.assets.new(asset_params)
  
      if @asset.save
        render json: @asset, status: :created # ,location: @asset
      else
        render json: @asset.errors, status: :unprocessable_entity
      end
    end
  
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
end
