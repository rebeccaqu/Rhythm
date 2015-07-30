namespace :userfail do
  desc "Rake task when users forget to input data"
  task :set_nil => :environment do
    User.each do |user|
      if user.daily_rhythms.last.date != Date.today
        user.date = Date.today
        user.cycle_num = user.daily_rhythms.last.cycle_num
        user.day_of_cycle = user.daily_rhythms.last.day_of_cycle + 1
        user.period = nil 
        user.period_flow = nil
        user.bbt = nil 
        user. cervical_fluid = nil
        user.pain = nil 
        user.mood = nil
        user.pill = nil
        user.sex = nil 
      end
    end
  end
end