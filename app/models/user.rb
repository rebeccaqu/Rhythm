class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true


  has_many :daily_rhythms

  def on_period?
    if daily_rhythms.count > 1
      daily_rhythms.last.period
    else
      return false
    end
  end 

  def last_cycle
    if daily_rhythms.count > 1
      daily_rhythms.last.cycle_num
    else
      return 0
    end
  end

  def last_day
    if daily_rhythms.count > 1
      daily_rhythms.last.day_of_cycle
    else
      return 0
    end
  end

  def fertile_window_end
    daily_rhythms.maximum(:day_of_cycle) - 11
  end

  def fertile_window_start
    i = 1
    max_days = []

    while i <= daily_rhythms.last.cycle_num
      max_days << daily_rhythms.where(cycle_num: i).count
      i += 1
    end

    max_days.min - 18
  end

end
