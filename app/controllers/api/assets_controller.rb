module Api
  class AssetsController < ApplicationController
    before_filter :permission, only: [:create, :destroy]
    
    def_param_group :asset do 
      # asset file
      param :product_id, Integer
    end
    
    api :GET, '/assets/:id', "Show an individual asset"
    def show
      @asset = Asset.find(params[:id])
  
      render json: @asset
    end
   
    api :POST, '/products/:id/assets', "Create an asset"
    param_group :asset
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
    
    api :DELETE, '/assets/:id', "Delete an asset"
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
