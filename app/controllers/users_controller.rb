class UsersController < ApplicationController
  before_filter :permission


  # GET /users
  # GET /users.json
  # def index
  #   @users = User.all

  #   render json: @users
  # end

  # GET /users/1
  # GET /users/1.json

  # /user -> json of all user data
  def show
    @user = current_user

    render json: @user
  end

  # POST /users
  # POST /users.json

  #  user created at login with twitter
  # def create
  #   @user = User.new(params[:user])

  #   if @user.save
  #     render json: @user, status: :created, location: @user
  #   else
  #     render json: @user.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json

  #  User.find(params[:id])
  # this is no longer used, so remove /user/:id to post to /user

  # PATCH/PUT /user
  def update
    @user = current_user

    if @user.update(params[:user])
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json

  # DELETE /users
  # def destroy
  #   @user = User.find(params[:id])
  #   @user.destroy

  #   head :no_content
  # end

  def user_params
    params.require(:user).permit(:email, :username, :full_name, :bio, :image)
  end

end
