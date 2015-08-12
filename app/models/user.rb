class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :daily_rhythms
  has_many :physicians, -> { where accepted: true }, :through => :friendships
  has_many :friendships
  has_many :requested_physicians, -> { where accepted: false }, class_name: 'Physician', through: :friendships, source: :physician

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true


  # CHECKS IF DB IS EMPTY: 
  # (1) on_period?, (2) last_cycle & (3) last_day makes sure our program
  # doesn't break if there are no previous DailyRhythm entries in our database

  def on_period?
    if daily_rhythms.count >= 1
      daily_rhythms.all[-1].period    # returns 'true' if on period
    else
      return false 
    end
  end 

  def last_cycle
    if daily_rhythms.count >= 1
      daily_rhythms.all[-1].cycle_num   # returns last cycle_num DOES IT REALLy
    else
      return 0  
    end
  end

  def last_day
    if daily_rhythms.count >= 1
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
    self.daily_rhythms.where("cycle_num = ? and period = ?", current_cycle, true).last
  end

  def current_cycle
    self.daily_rhythms.last.cycle_num
  end

  def regular_day
    self.daily_rhythms.where("cycle_num=? and period =?", current_cycle, false).count
  end

  # ANALYTICS FOR PREDICTED DATA:

  def fertile_window_start
    i = 1
    max_days = []

    while i < current_cycle
      max_days << daily_rhythms.where(cycle_num: i).count
      i += 1
    end

    max_days.min - 18
  end

  def fertile_window_end
    daily_rhythms.maximum(:day_of_cycle) - 11
  end

  def avg_period
    past_cycle_period = daily_rhythms.where('period=? AND cycle_num < ?', true, current_cycle)
    total = past_cycle_period.count
    total / past_cycle_period.maximum(:cycle_num)
  end
  
  def past_cycle_rhythms
    daily_rhythms.where('cycle_num < ?', current_cycle)
  end

  def avg_cycle_length
    i = 1
    total_days = 0

    while i < current_cycle
      total_days += daily_rhythms.where(cycle_num: i).count
      i += 1
    end

    last_cycle = current_cycle - 1

    (total_days / last_cycle).to_i
  end

  def period_and_fertile_days
    daily_rhythms.select do |dr|
      dr.on_period || (dr.day_of_cycle >= fertile_window_start && dr.day_of_cycle <= fertile_window_end)
    end
  end

end
