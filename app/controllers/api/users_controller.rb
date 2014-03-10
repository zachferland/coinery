module Api
  class UsersController < ApplicationController
    before_filter :permission

    def_param_group :user do 
      param :email, String
      param :username, String
      param :full_name, String
      # param :bio, Text
    end
    
    api :GET, '/users', "Get user info"
    param_group :user
    def show
      @user = current_user
  
      render json: @user
    end
    
    api :PUT, '/users', "Update user"
    param_group :user
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
