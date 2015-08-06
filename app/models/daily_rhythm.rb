class DailyRhythm < ActiveRecord::Base
  belongs_to :user

  # Method 1: DailyRhythm gets populated with default data only when date doesn't exist, 
  # if date already exists, populate_rhythm_default doesn't get called
  # This precaution is to prevent the date, cycle_num and day_of_cycle from being re-populated
  # when a particular DailyRhythm is being updated
  before_save :populate_rhythm_default, if: -> { self.date.blank? } 

  
  # Before each DailyRhythm is SAVED, populates each instance of DailyRhythm with:
  # (1) Today's Date, (2) Cycle Num, (3) Day of Cycle

  def populate_rhythm_default
    # return if self.date.present? # Method 2

    # if self.date.blank? # Method 3
    
    self.date = Date.today      # Date is assigned to today's date

    if (user.on_period? == false) && (self.period == true)  # At the beginning of each cycle, cycle_num increases by 1, day_of_cycle = 1
      self.cycle_num = user.last_cycle + 1
      self.day_of_cycle = 1
    else                                     # During the cycle, cycle_num stays the same, day_of_cycle increases by 1
      self.cycle_num = user.last_cycle
      self.day_of_cycle = user.last_day + 1
    end

  end

end