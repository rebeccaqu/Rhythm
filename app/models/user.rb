class User < ActiveRecord::Base
  has_many :daily_rhythms

  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true


  # Auto-generated data: 

  def on_period?
    if daily_rhythms.count > 1
      daily_rhythms.all[-1].period
    else
      return false
    end
  end 

  def last_cycle
    if daily_rhythms.count > 1
      daily_rhythms.all[-1].cycle_num
    else
      return 0
    end
  end

  def last_day
    if daily_rhythms.count > 1
      daily_rhythms.all[-1].day_of_cycle
    else
      return 0
    end
  end

  # Upcoming Cycle:

  def fertile_window_start
    i = 1
    max_days = []

    while i <= daily_rhythms.last.cycle_num
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

  # Current Cycle: 
  def day_of_cycle
      if daily_rhythms.last.date != Date.today 
        daily_rhythms.last.day_of_cycle + 1 
      else
        daily_rhythms.last.day_of_cycle
      end
  end

  def first_day_of_period
    daily_rhythms.where(day_of_cycle: 1).order('cycle_num DESC').first
  end

  def last_day_of_period
    curr_cycle = self.daily_rhythms.last.cycle_num
    self.daily_rhythms.where("cycle_num = ? and period = ?", curr_cycle, true).last
  end
end
