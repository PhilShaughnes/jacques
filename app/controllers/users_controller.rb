class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      request_error(@user.errors.full_messages)
    end
  end

  def login
    @user = User.find_by(username: params[:username])
    puts "*************************************************"
    p params
    puts "**************************************************"

    if @user && authenticate(params[:password])
      render json: @user
    else
      request_error(["Invalid username or password"], 401)
    end
  end

  private
  def user_params
    params.permit(:username, :email, :password)
  end
end
