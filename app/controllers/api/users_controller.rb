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
    def show
      @user = current_user

      render json: @user
    end

    api :PUT, '/users', "Update user"
    param_group :user
    def update
      @user = current_user

      # this probably does not work
      # need better logic, for when a user if signed up, they are create on login, but we can only send them email once they give us an email as well
      if !current_user.email && !!user_params['email']
        Notifier.send_signup_email(@identity.user).deliver
      end

      if @user.update(user_params)
        head :no_content
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def user_params
      params.permit(:email, :username, :full_name, :bio, :img)
    end

  end
end
