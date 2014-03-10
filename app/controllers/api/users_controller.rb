module Api
  class UsersController < ApplicationController
    before_filter :permission
  
    def show
      @user = current_user
  
      render json: @user
    end
  
    def update
      @user = current_user
  
      if @user.update(params[:user])
        head :no_content
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    def user_params
      params.require(:user).permit(:email, :username, :full_name, :bio, :image)
    end
  
  end
end
