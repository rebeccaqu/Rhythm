class DailyRhythmsController < ApplicationController
  before_filter :load_user

  def index
    
  end

  def new
    @daily_rhythm = DailyRhythm.new
  end

  def create
    @daily_rhythm = @user.daily_rhythms.build(daily_rhythm_params)

    if @daily_rhythm.save
      redirect_to user_url(params[:user_id]) 
    else
      render :new, notice: "Save failed, please enter info again"
    end
  end

  def show
    @daily_rhythm = DailyRhythm.find(params[:id])
  end

  def edit
  end

  def update
  end

  private
  def daily_rhythm_params
    params.require(:daily_rhythm).permit(:cycle_num, :date, :period, :period_flow, :bbt, :cervical_fluid, :pain, :mood, :pill, :sex)
  end

  def load_user
    @user = User.find(params[:user_id])
  end
end
