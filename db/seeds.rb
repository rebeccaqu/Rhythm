
User.destroy_all()
DailyRhythm.destroy_all()

u1 = User.create({
  first_name: "Aysha",
  last_name: "Eda",
  email: "Aysha@bitmaker.com",
  password: "password", 
  password_confirmation: "password"
})

u2 = User.create({
  first_name: "Rebecca",
  last_name: "Qu",
  email: "Rebecca@bitmaker.com",
  password: "password", 
  password_confirmation: "password"
})


startdate = 60.days.ago   # Since we have 90 days in total: 60 days are past, 30 days are future
days_into_history = 1     # Sets first day as 1 instead of 0 (default)


(1..3).each do |c|      # Creates 3 cycles, each 30 days in length

  period_length = 3 + Random.rand(4)     # Randomized period lengths (3-7 days)
  rest_length = 30 - period_length      # Randomized rest-of-cycle lengths (23-27 days)

    period_length.times do |i|

      DailyRhythm.create({
        cycle_num: c,
        day_of_cycle: i+1,
        date: startdate + days_into_history.days,
        period: true, 
        period_flow: [:light, :medium, :heavy].sample,
        bbt:  rand(97.7..98.7),
        cervical_fluid: ['egg-white', 'sticky', 'cloudy', 'dry', 'atypical', 'period'].sample, 
        pain: rand(1..10), 
        mood: ['normal', 'irritable', 'happy', 'sad', 'sensitive'].sample, 
        pill:  ['taken', 'missed', 'late', 'double'].sample,
        sex: ['unprotected', 'protected', 'withdraw', 'none'].sample,
        user_id: u1.id})

      days_into_history += 1

    end

    rest_length.times do |i| 

      DailyRhythm.create({
        cycle_num: c,
        day_of_cycle: i + 1 + period_length,
        date: startdate + days_into_history.days,
        period: false, 
        period_flow: [:light, :medium, :heavy].sample,
        bbt:  rand(97.7..98.7),
        cervical_fluid: ['egg-white', 'sticky', 'cloudy', 'dry', 'atypical', 'period'].sample, 
        pain: rand(1..10), 
        mood: ['normal', 'irritable', 'happy', 'sad', 'sensitive'].sample, 
        pill: ['taken', 'missed', 'late', 'double'].sample,
        sex: ['unprotected', 'protected', 'withdraw', 'none'].sample,
        user_id: u1.id})

      days_into_history += 1

  end
end


(1..3).each do |c|      # Creates 3 cycles, each 30 days in length

  period_length = 3 + Random.rand(4)     # Randomized period lengths (3-7 days)
  rest_length = 30 - period_length      # Randomized rest-of-cycle lengths (23-27 days)

    period_length.times do |i|

      DailyRhythm.create({
        cycle_num: c,
        day_of_cycle: i+1,
        date: startdate + days_into_history.days,
        period: true, 
        period_flow: [:light, :medium, :heavy].sample,
        bbt:  rand(97.7..98.7),
        cervical_fluid: ['egg-white', 'sticky', 'cloudy', 'dry', 'atypical', 'period'].sample, 
        pain: rand(1..10), 
        mood: ['normal', 'irritable', 'happy', 'sad', 'sensitive'].sample, 
        pill:  ['taken', 'missed', 'late', 'double'].sample,
        sex: ['unprotected', 'protected', 'withdraw', 'none'].sample,
        user_id: u2.id})

      days_into_history += 1

    end

    rest_length.times do |i| 

      DailyRhythm.create({
        cycle_num: c,
        day_of_cycle: i + 1 + period_length,
        date: startdate + days_into_history.days,
        period: false, 
        period_flow: [:light, :medium, :heavy].sample,
        bbt:  rand(97.7..98.7),
        cervical_fluid: ['egg-white', 'sticky', 'cloudy', 'dry', 'atypical', 'period'].sample, 
        pain: rand(1..10), 
        mood: ['normal', 'irritable', 'happy', 'sad', 'sensitive'].sample, 
        pill: ['taken', 'missed', 'late', 'double'].sample,
        sex: ['unprotected', 'protected', 'withdraw', 'none'].sample,
        user_id: u2.id})

      days_into_history += 1

  end
end


