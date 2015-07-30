
  namespace :userfail do
    desc "Rake task when users forget to input data"
      task :set_nil => :environment do
        
        User.all.each do |user|

          if !user.daily_rhythms.last.nil? && (user.daily_rhythms.last.date != Date.today)

            DailyRhythm.create({
              cycle_num: user.daily_rhythms.last.cycle_num,
              day_of_cycle: user.daily_rhythms.last.day_of_cycle + 1,
              date: Date.today,
              period: nil, 
              period_flow: nil,
              bbt: nil,
              cervical_fluid: nil, 
              pain: nil, 
              mood: nil, 
              pill: nil,
              sex: nil,
              user_id: user.id 
            })

        end
      end
    end
  end
