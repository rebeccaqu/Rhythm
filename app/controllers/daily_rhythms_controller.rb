class DailyRhythmsController < ApplicationController
  before_filter :load_user

  def index
    @user = User.find(params[:user_id])
    @daily_rhythms = @user.daily_rhythms
   
    # respond_to do |format|
    #   format.html
    #   format.ics do
    #     calendar = Icalendar::Calender.new
    #     @user.period_and_fertile_days.each do |dr|
    #       calendar.add_event(dr.to_ics)
    #     end
    #     c.publish
    #     render text: calendar.to_ical
    #   end
    # end
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
    @daily_rhythm = User.find(params[:user_id]).daily_rhythms.find(params[:id])
  end

  def update
    @daily_rhythm = @user.daily_rhythms.find(params[:id])
    @daily_rhythm.update_attributes(daily_rhythm_params)

    if @daily_rhythm.save
      redirect_to user_url(params[:user_id])
    else
      render :edit, notice: "Failed to Update, please enter info again"
    end
  end

  private
  def daily_rhythm_params
    params.require(:daily_rhythm).permit(:first_day_of_cycle, :cycle_num, :date, :period, :period_flow, :bbt, :cervical_fluid, :pain, :mood, :pill, :sex)
  end

  def load_user
    @user = User.find(params[:user_id])
  end
end
