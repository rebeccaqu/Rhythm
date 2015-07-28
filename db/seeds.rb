# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all()
DailyRhythm.destroy_all()

u1 = User.create! ({
  first_name: "Aysha",
  last_name: "Eda",
  email: "Aysha@bitmaker.com",
  password: "password", 
  password_confirmation: "password"

})

u2 = User.create! ({
  first_name: "Rebecca",
  last_name: "Qu",
  email: "Rebecca@bitmaker.com",
  password: "password", 
  password_confirmation: "password"
})

r1 = DailyRhythm.create! ({
  cycle_num: 1,
  day_of_cycle: 1,
  date: Date.today,
  period: true, 
  period_flow: "light",
  bbt: 97.8,
  cervical_fluid: "flow", 
  pain: 6, 
  mood: "irritable", 
  pill: "taken",
  sex: "protected",
  user_id: u1.id
  })






