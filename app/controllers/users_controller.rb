class UsersController < ApplicationController

skip_before_filter :require_login, only: [:index, :new, :create]
  
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      redirect_to(user_path(current_user), notice: 'User was successfully created')
    else
      render :new, :notice => "Try again"
    end
  end

  def show
    @user = User.find(params[:id])
    gon.first_day = @user.first_day_of_period
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, daily_rhythms_attributes: [:period, :period_flow, :cervical_fluid, :pain, :mood, :pill, :sex] ) 
  end
end
