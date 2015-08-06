class User < ActiveRecord::Base
  has_many :daily_rhythms

  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true


  # CHECKS IF DB IS EMPTY: 
  # (1) on_period?, (2) last_cycle & (3) last_day makes sure our program
  # doesn't break if there are no previous DailyRhythm entries in our database

  def on_period?
    if daily_rhythms.count > 1
      daily_rhythms.all[-1].period    # returns 'true' if on period
    else
      return false 
    end
  end 

  def last_cycle
    if daily_rhythms.count > 1
      daily_rhythms.all[-1].cycle_num   # returns last cycle_num
    else
      return 0  
    end
  end

  def last_day
    if daily_rhythms.count > 1
      daily_rhythms.all[-1].day_of_cycle  # returns last day_of_cycle
    else
      return 0
    end
  end

  def day_of_cycle
      if daily_rhythms.last.date != Date.today 
        daily_rhythms.last.day_of_cycle + 1 
      else
        daily_rhythms.last.day_of_cycle
      end
  end

  # ANALYTICS WITH DATA FROM CURRENT CYCLE: 

  def first_day_of_period
    # daily_rhythms.where(first_day_of_cycle: true).order('cycle_num DESC').first
    daily_rhythms.where(day_of_cycle: 1).order('cycle_num DESC').first
  end

  def last_day_of_period
    current_cycle = self.daily_rhythms.last.cycle_num
    self.daily_rhythms.where("cycle_num = ? and period = ?", current_cycle, true).last
  end

  # ANALYTICS FOR PREDICTED DATA:

  def fertile_window_start
    i = 1
    max_days = []

    while i < daily_rhythms.last.cycle_num
      max_days << daily_rhythms.where(cycle_num: i).count
      i += 1
    end

    max_days.min - 18
  end

  def fertile_window_end
    daily_rhythms.maximum(:day_of_cycle) - 11
  end

  def avg_period
    total = daily_rhythms.where(period: true).count
    total / daily_rhythms.maximum(:cycle_num)
  end

  def avg_cycle_length
    i = 1
    total_days = 0

    while i <= daily_rhythms.last.cycle_num
      total_days += daily_rhythms.where(cycle_num: i).count
      i += 1
    end

    (total_days / daily_rhythms.last.cycle_num).to_i
  end

end
