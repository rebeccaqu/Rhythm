class UsersController < ApplicationController

skip_before_filter :require_login, only: [:index, :new, :create]
  
  def index
    # @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to(root_url, notice: 'User was successfully created')
      # redirect_back_or_to root_url, :notice => "Signed up!"
    else
      render :new, :notice => "Try again"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
