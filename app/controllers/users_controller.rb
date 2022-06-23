class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def create
    # @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    @user = User.new(user_params)

    if @user.save
      redirect_to new_user_path, alert: "User created successfully."
    else
      flash.now[:error] = "Invalid user input"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to edit_user_path(:id)
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def find_user
      @user = User.find(params[:id])
    end
end
