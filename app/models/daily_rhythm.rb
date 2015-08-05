class DailyRhythm < ActiveRecord::Base
  belongs_to :user

  before_save :populate_rhythm_default, if: -> { self.date.blank? }

  def populate_rhythm_default
    # return if self.date.present?

    # if self.date.blank? 
    
    self.date = Date.today

    if (user.on_period? == false) && (self.period == true)  
      self.cycle_num = user.last_cycle + 1
      self.day_of_cycle = 1
    else
      self.cycle_num = user.last_cycle
      self.day_of_cycle = user.last_day + 1
    end

  end

end