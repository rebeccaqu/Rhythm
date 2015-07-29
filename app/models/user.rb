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
end
