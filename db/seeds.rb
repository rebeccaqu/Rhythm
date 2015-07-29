# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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


startdate = Date.today
days_into_history = 1

3.times do |c| 
  #these seeds are adjusted for accuracy - not actual logic
  period_length = 3 + Random.rand(4)
  rest_length = 30 - period_length

  period_length.times do |i| 
    DailyRhythm.create({
      cycle_num: c,
      day_of_cycle: i,
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
    DailyRhythm.create(
      cycle_num: c,
      day_of_cycle: i + period_length,
      date: startdate + days_into_history.days,
      period: false, 
      period_flow: [:light, :medium, :heavy].sample,
      bbt:  rand(97.7..98.7),
      cervical_fluid: ['egg-white', 'sticky', 'cloudy', 'dry', 'atypical', 'period'].sample, 
      pain: rand(1..10), 
      mood: ['normal', 'irritable', 'happy', 'sad', 'sensitive'].sample, 
      pill: ['taken', 'missed', 'late', 'double'].sample,
      sex: ['unprotected', 'protected', 'withdraw', 'none'].sample,
      user_id: u1.id )
    days_into_history += 1
  end 

end



