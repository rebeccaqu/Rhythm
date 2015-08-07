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
      render :new, notice: "Try again"
    end
  end

  def show
    @user = User.find(params[:id])

    if current_user.daily_rhythms.count > 0

      if current_user.daily_rhythms.last.cycle_num > 2

        # AVERAGE CYCLE: 
        gon.average_period_length = @user.avg_period
        gon.average_cycle_window_one = @user.fertile_window_start - @user.avg_period
        gon.average_fertility_window_length = @user.fertile_window_end - @user.fertile_window_start
        gon.average_cycle_window_two = @user.avg_cycle_length - @user.fertile_window_end  

        gon.fertility_window = @user.fertile_window_end - @user.fertile_window_start
        gon.cycle_window_one = @user.fertile_window_start - @user.last_day_of_period.day_of_cycle
        gon.cycle_window_two = @user.avg_cycle_length - @user.fertile_window_end

      end

      # CURRENT CYCLE: 
      gon.first_day = @user.first_day_of_period.day_of_cycle 
      gon.last_day = @user.last_day_of_period.day_of_cycle
      gon.period_length = gon.last_day

      gon.regular_day = @user.regular_day
   
      current_cycle_num = @user.daily_rhythms.last.cycle_num
      gon.rhythm_ids = @user.daily_rhythms.where({cycle_num: current_cycle_num}).order(:day_of_cycle).map(&:id)

    end
  end

  def download_ical

     @daily_rhythm = DailyRhythm.find(params[:id])

     @user_daily_rhythms = DailyRhythm.all

      respond_to do |format|
        format.ics do 
          calendar = Icalendar::Calendar.new
          @user_daily_rhythms.each do |daily_rhythm|
            event = Icalendar::Event.new
            event.dtstart = daily_rhythm.date 
            event.summary = daily_rhythm.summary
            calendar.add_event(event)
            calendar.publish
          end 
          render :text => calendar.to_ical          
        end
      end

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, daily_rhythms_attributes: [:period, :period_flow, :cervical_fluid, :pain, :mood, :pill, :sex] ) 
  end
end
